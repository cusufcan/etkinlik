part of 'profile_view.dart';

abstract class _ProfileViewModel extends ConsumerState<ProfileView> {
  late final AppString _appString = AppString();

  bool _imageLock = false;
  bool _editLock = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  bool _isEditEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.user == null) {
      _usernameController.text = ref.read(userProvider).name;
      _aboutController.text = ref.read(userProvider).about;
    } else {
      _usernameController.text = widget.user!.name;
      _aboutController.text = widget.user!.about;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _imageLoading() => setState(() => _imageLock = !_imageLock);
  void _editLoading() => setState(() => _editLock = !_editLock);

  Future<void> _changeProfileImage() async {
    _imageLoading();

    ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      _imageLoading();
      return;
    }

    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 3),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.blueAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
      ],
    );

    if (croppedFile == null) {
      _imageLoading();
      return;
    }

    await ref
        .read(userProvider.notifier)
        .changeProfileImage(File(croppedFile.path));

    _msg();
    _imageLoading();
  }

  void _deleteProfileImage() async {
    _imageLoading();

    await showCustomAlertDialog(
      context: context,
      title: 'Fotoğrafı Kaldır',
      content: 'Profil fotoğrafınızı kaldırmak istediğinize emin misiniz?',
      buttonTitle: 'Sil',
      onPressed: () async {
        await ref
            .read(userProvider.notifier)
            .deleteProfileImage()
            .then((value) => Navigator.of(context).pop());

        _msg();
      },
    );

    _imageLoading();
  }

  void _onSaveTap() async {
    if (_isEditEnabled) {
      _editEnabled();
      _editLoading();

      await ref.read(userProvider.notifier).changeProfileInfo(
            _usernameController.text.trim(),
            _aboutController.text.trim(),
          );

      _msg();
      _editLoading();
    } else {
      _editEnabled();
    }
  }

  void _editEnabled() => setState(() => _isEditEnabled = !_isEditEnabled);

  void _deleteAccount() async {
    final TextEditingController controller = TextEditingController();

    _imageLoading();
    _editLoading();

    await showCustomAlertDialog(
      context: context,
      title: 'Hesabı Sil',
      contentWidget: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Şifrenizi girin',
          border: OutlineInputBorder(),
        ),
      ),
      content: 'Hesabınızı silmek istediğinize emin misiniz?',
      buttonTitle: 'Sil',
      onPressed: () async {
        final credential = EmailAuthProvider.credential(
          email: ref.read(userProvider).email,
          password: controller.text.trim(),
        );

        await ref
            .read(userProvider.notifier)
            .deleteAccount(credential)
            .then((value) => Navigator.of(context).pop());

        _goToAuthPage();
      },
    );

    _imageLoading();
    _editLoading();
  }

  void _msg() => showMessage(context, 'Değişiklikler kaydedildi.');

  void _goToAuthPage() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AuthView(),
      ),
    );
  }
}
