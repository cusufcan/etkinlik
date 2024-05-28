part of 'main_view.dart';

abstract class _MainViewModel extends ConsumerState<MainView> {
  final PageController _pageController = PageController();
  late List<Widget> _pages;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeView(),
      const NotificationsView(),
      const ProfileView(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navBarOnTap(int page) {
    setState(() {
      _currentPage = page;
    });
    _pageController.jumpToPage(page);
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }
}
