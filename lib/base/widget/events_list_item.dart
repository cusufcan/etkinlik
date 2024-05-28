import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:etkinlik/feature/event_details/event_details_view.dart';
import 'package:etkinlik/model/event.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsListItem extends ConsumerWidget {
  const EventsListItem({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Event event = ref.watch(eventProvider).firstWhere(
          (element) => element.id == id,
          orElse: () => Event.empty(),
        );

    if (event.isEmpty) {
      return const SizedBox();
    }

    return CustomCard(
      margin: EdgeInsets.zero,
      child: ListTile(
        title: Text(
          event.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          event.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: event.creatorId == FirebaseAuth.instance.currentUser!.uid
            ? const Icon(Icons.person_outlined)
            : const Icon(
                Icons.arrow_forward_ios,
              ),
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            event.imageUrl,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EventDetailsView(id: id),
            ),
          );
        },
      ),
    );
  }
}
