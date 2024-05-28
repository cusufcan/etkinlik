import 'package:etkinlik/feature/main/main_view.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:etkinlik/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  void _initApp() async {
    await ref.read(userProvider.notifier).fetchUser();
    await ref.read(eventProvider.notifier).fetchEvents();

    _goToMainView();
  }

  void _goToMainView() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (ctx, anim, secondAnim) => const MainView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
