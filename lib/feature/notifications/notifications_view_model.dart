part of 'notifications_view.dart';

abstract class _NotificationsViewModel
    extends ConsumerState<NotificationsView> {
  Future<void> _acceptNotification(MyNotification notification) async {
    await ref.read(eventProvider.notifier).acceptEventRequest(notification);
    ref.read(userProvider.notifier).deleteNotification(notification);
  }

  Future<void> _rejectNotification(MyNotification notification) async {
    await ref.read(eventProvider.notifier).rejectEventRequest(notification);
    ref.read(userProvider.notifier).deleteNotification(notification);
  }
}
