part of 'auth_view.dart';

abstract class _AuthViewModel extends ConsumerState<AuthView> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _username = '';
  String _email = '';
  String _password = '';
  File? _selectedImage;

  bool _isLogin = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    _hideKeyboard();

    final isValid = _form.currentState!.validate();
    if (!isValid) return;

    _form.currentState!.save();

    try {
      _loading();

      if (_isLogin) {
        await ref.read(userProvider.notifier).signInUser(_email, _password);
        await ref.read(userProvider.notifier).fetchUser();
        _goToSplashPage();
      } else {
        await ref.read(userProvider.notifier).createUser(_email, _password);
        final imageUrl =
            await ref.read(userProvider.notifier).uploadImage(_selectedImage);

        await ref.read(userProvider.notifier).setUserToDB(MyUser(
              id: FirebaseAuth.instance.currentUser!.uid,
              email: _email,
              name: _username,
              photoURL: imageUrl,
              about: 'Merhaba! Burada yeniyim.',
              createdEvents: const [],
              joinedEvents: const [],
            ));

        _goToSplashPage();
      }
    } on FirebaseAuthException catch (error) {
      _msg(error.message ?? 'İşlem başarısız.');

      _loading();
    }
  }

  void _msg(String msg) => showMessage(context, msg);

  void _goToSplashPage() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SplashView(),
      ),
    );
  }

  void _changeAuthMode() {
    _hideKeyboard();

    _form.currentState!.reset();

    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();

    _username = '';
    _email = '';
    _password = '';

    setState(() => _isLogin = !_isLogin);
  }

  void _hideKeyboard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _loading() => setState(() => _isLoading = !_isLoading);
}
