import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/helper/messenger.dart';
import 'package:etkinlik/feature/notifications/widget/notification_item.dart';
import 'package:etkinlik/model/my_notification.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:etkinlik/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'notifications_view_model.dart';

class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({super.key});

  @override
  ConsumerState<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends _NotificationsViewModel {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(userProvider.notifier).fetchUser().then(
          (_) {
            if (ref.read(userProvider).notifications.isEmpty) {
              showMessage(context, 'Gösterilecek bildirim yok.');
            }
          },
        );
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(
          AppNum.medium,
        ),
        itemCount: ref.watch(userProvider).notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = ref.read(userProvider).notifications[index];
          return NotificationItem(
            title: notification.title,
            body: notification.body,
            onAccept: () => _acceptNotification(notification),
            onReject: () => _rejectNotification(notification),
          );
        },
      ),
    );
  }
}
