import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/feature/profile/widget/events_info_button.dart';
import 'package:etkinlik/feature/profile/widget/profile_events_list.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:etkinlik/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformation extends ConsumerStatefulWidget {
  const UserInformation({super.key});

  @override
  ConsumerState<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends ConsumerState<UserInformation> {
  int _activeList = 0;

  void _onActiveListChange(int index) {
    setState(() => _activeList = index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppNum.xxSmall,
      ),
      child: Column(
        children: [
          Row(
            children: [
              EventsInfoButton(
                text: 'Katıldıklarım',
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppNum.xSmall),
                ),
                isActive: _activeList == 0,
                onTap: () => _onActiveListChange(0),
              ),
              EventsInfoButton(
                text: 'Düzenlediklerim',
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppNum.xSmall),
                ),
                isActive: _activeList == 1,
                onTap: () => _onActiveListChange(1),
              ),
            ],
          ),
          if (_activeList == 0)
            ProfileEventsList(
              events: ref
                  .watch(eventProvider)
                  .where((event) =>
                      ref.watch(userProvider).joinedEvents.contains(event.id))
                  .toList(),
            ),
          if (_activeList == 1)
            ProfileEventsList(
              events: ref
                  .watch(eventProvider)
                  .where((event) =>
                      ref.watch(userProvider).createdEvents.contains(event.id))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
