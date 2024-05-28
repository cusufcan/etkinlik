import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/helper/date_helper.dart';
import 'package:etkinlik/base/helper/messenger.dart';
import 'package:etkinlik/feature/event_details/widget/event_detail_image.dart';
import 'package:etkinlik/feature/event_details/widget/event_detail_item.dart';
import 'package:etkinlik/feature/event_details/widget/event_join_button.dart';
import 'package:etkinlik/feature/event_details/widget/joined_users_list.dart';
import 'package:etkinlik/model/event.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:etkinlik/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'event_details_view_model.dart';

class EventDetailsView extends ConsumerStatefulWidget {
  const EventDetailsView({
    super.key,
    required this.id,
  });

  final String id;

  @override
  ConsumerState<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends _EventDetailsViewModel {
  @override
  Widget build(BuildContext context) {
    Event event = ref.watch(eventProvider).firstWhere(
        (element) => element.id == widget.id,
        orElse: () => Event.empty());

    final String uid = FirebaseAuth.instance.currentUser!.uid;

    if (event.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.title,
        ),
        actions: [
          if (event.creatorId == uid)
            IconButton(
              tooltip: 'Sil',
              icon: Icon(
                Icons.delete_outlined,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: _deleteEvent,
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return await ref.watch(eventProvider.notifier).fetchEvents();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EventDetailImage(
                id: event.id,
                url: event.imageUrl,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppNum.medium,
                  horizontal: AppNum.small,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EventDetailItem(
                      text: event.title,
                      icon: Icons.title_outlined,
                    ),
                    EventDetailItem(
                      text: event.description,
                      icon: Icons.description_outlined,
                    ),
                    EventDetailItem(
                      text: '${event.date} / ${event.time}',
                      icon: Icons.calendar_month_outlined,
                    ),
                    EventDetailItem(
                      text: event.location,
                      icon: Icons.location_on_outlined,
                    ),
                    EventDetailItem(
                      text: '${event.joinedUsers.length}/${event.capacity}',
                      icon: Icons.people_outlined,
                    ),
                  ],
                ),
              ),
              if (convertToDateTime(event.date, event.time)
                  .isBefore(DateTime.now()))
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppNum.large,
                    vertical: AppNum.medium,
                  ),
                  child: Center(child: Text("Etkinlik bitti")),
                ),
              if (convertToDateTime(event.date, event.time)
                      .isAfter(DateTime.now()) &&
                  event.creatorId != uid &&
                  event.joinedUsers.length < event.capacity &&
                  !event.joinedUsers.contains(uid) &&
                  !event.requestUsers.contains(uid))
                EventJoinButton(
                  label: 'Katılma Talebi Gönder',
                  onPressed: () => _buttonEvent(ButtonEventType.request),
                ),
              if (convertToDateTime(event.date, event.time)
                      .isAfter(DateTime.now()) &&
                  event.creatorId != uid &&
                  event.requestUsers.contains(uid))
                EventJoinButton(
                  label: 'Talebi İptal Et',
                  onPressed: () => _buttonEvent(ButtonEventType.cancel),
                ),
              if (convertToDateTime(event.date, event.time)
                      .isAfter(DateTime.now()) &&
                  event.creatorId != uid &&
                  event.joinedUsers.contains(uid))
                EventJoinButton(
                  label: 'Çık',
                  onPressed: () => _buttonEvent(ButtonEventType.leave),
                ),
              if (event.creatorId == uid && event.joinedUsers.isNotEmpty)
                FutureBuilder(
                  future: ref
                      .read(userProvider.notifier)
                      .getUsersByIds(event.joinedUsers),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Hata: ${snapshot.error}',
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppNum.large,
                          ),
                          child: Text(
                            'Katılımcılar:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: AppNum.xSmall),
                        JoinedUsersList(
                          joinedUsers: snapshot.data!,
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
