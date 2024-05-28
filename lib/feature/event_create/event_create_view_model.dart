part of 'event_create_view.dart';

abstract class _EventCreateViewModel extends ConsumerState<EventCreateView> {
  late final AppString _appString = AppString();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _selectedImage;

  String? _imageUrl;
  String? _title;
  int? _capacity;
  String? _date;
  String? _time;
  String? _description;
  String? _location;

  bool _isLoading = false;

  LatLng? _locationLatLng;

  void _loading() => setState(() => _isLoading = !_isLoading);

  Future<void> _pickLocation() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return LocationPickView(
          currentLatLng: _locationLatLng ??
              const LatLng(40.331198416252874, 36.47987169434791),
          onLocationPicked: (result) {
            setState(() {
              _location = result?.formattedAddress;

              final latitude = result?.geometry.location.lat ?? 0.0;
              final longitude = result?.geometry.location.lng ?? 0.0;
              _locationLatLng = LatLng(latitude, longitude);
            });
          },
        );
      },
    ));
  }

  Future<void> _pickDate() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 335),
      ),
      initialDate: DateTime.now(),
    );

    if (selectedDate == null) return;

    final formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

    setState(() {
      _date = formattedDate;
    });

    await _pickTime();
  }

  Future<void> _pickTime() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );

    if (selectedTime == null) return;

    // ignore: use_build_context_synchronously
    final formattedTime = "${selectedTime.hour}:${selectedTime.minute}";

    setState(() {
      _time = formattedTime;
    });
  }

  void _submit() async {
    _loading();

    if (!_formKey.currentState!.validate()) {
      _loading();
      return;
    }

    if (_location == null) {
      showMessage(context, 'Konum seçmelisiniz.');
      _loading();
      return;
    }

    if (_date == null || _time == null) {
      showMessage(context, 'Tarih ve saat seçmelisiniz.');
      _loading();
      return;
    }

    final eventId = const Uuid().v4();

    if (_selectedImage != null) {
      _imageUrl = await ref
          .read(eventProvider.notifier)
          .uploadImage(eventId, _selectedImage!);
    }

    _formKey.currentState!.save();

    final event = Event(
      id: eventId,
      imageUrl: _imageUrl ?? _appString.defaultEventImageUrl,
      title: _title!,
      capacity: _capacity!,
      description: _description!,
      date: _date!,
      time: _time!,
      location: _location!,
      creatorId: FirebaseAuth.instance.currentUser!.uid,
      joinedUsers: [],
      requestUsers: [],
    );

    await ref.read(userProvider.notifier).createEvent(event.id);

    await ref.read(eventProvider.notifier).addEvent(event).then(
          (value) => Navigator.of(context).pop(),
        );

    _loading();
  }
}
