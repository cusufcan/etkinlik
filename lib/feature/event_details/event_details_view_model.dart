part of 'event_details_view.dart';

abstract class _EventDetailsViewModel extends ConsumerState<EventDetailsView> {
  void _deleteEvent() {
    final Event event = ref
        .watch(eventProvider)
        .firstWhere((element) => element.id == widget.id);
    showCustomAlertDialog(
      context: context,
      title: 'Etkinliği Sil',
      content:
          'Etkinliği silmek istediğinize emin misiniz? Bu işlem geri alınamaz.',
      buttonTitle: 'Sil',
      onPressed: () async {
        Navigator.of(context).pop();

        await ref
            .read(eventProvider.notifier)
            .removeEvent(event)
            .then((value) => Navigator.of(context).pop());
      },
    );
  }

  Future<void> _buttonEvent(ButtonEventType type) async {
    Event event = ref
        .read(eventProvider)
        .firstWhere((element) => element.id == widget.id);

    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('events').doc(event.id).get().then((value) async {
      if (value.data() == null) {
        showMessage(
          context,
          'Etkinlik silinmiş veya güncellenmiş olabilir.',
        );
        return;
      }

      Event dbEvent = Event.fromMap(value.data()!);
      if (dbEvent.joinedUsers.length != event.joinedUsers.length) {
        if (dbEvent.joinedUsers.length == dbEvent.capacity &&
            !dbEvent.joinedUsers
                .contains(FirebaseAuth.instance.currentUser!.uid)) {
          showMessage(
            context,
            'Etkinlik kapasitesi doldu! Katılım sağlanamadı.',
          );
        }

        await ref
            .read(eventProvider.notifier)
            .updateEvent(dbEvent)
            .then((value) {
          event = ref
              .read(eventProvider)
              .firstWhere((element) => element.id == widget.id);
        });
      } else {
        switch (type) {
          case ButtonEventType.leave:
            ref.read(userProvider.notifier).leaveEvent(event.id);
            ref.read(eventProvider.notifier).leaveEvent(event);
            break;
          case ButtonEventType.request:
            ref.read(eventProvider.notifier).requestToJoinEvent(event);
            break;
          case ButtonEventType.cancel:
            await ref.read(eventProvider.notifier).cancelEventRequest(event);
            break;
          default:
        }
      }
    });
  }
}

enum ButtonEventType {
  join,
  leave,
  request,
  cancel,
}
