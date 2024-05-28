import 'package:etkinlik/feature/home/home_view.dart';
import 'package:etkinlik/feature/main/widget/app_nav_bar.dart';
import 'package:etkinlik/feature/main/widget/user_app_bar.dart';
import 'package:etkinlik/feature/notifications/notifications_view.dart';
import 'package:etkinlik/feature/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'main_view_model.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends _MainViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: AppNavBar(
        currentPage: _currentPage,
        onTap: _navBarOnTap,
      ),
    );
  }
}
