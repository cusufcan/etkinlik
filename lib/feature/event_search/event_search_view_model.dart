part of 'event_search_view.dart';

abstract class _EventSearchViewModel extends ConsumerState<EventSearchView> {
  final List<Event> _searchList = [];

  void _onSearchChange(String value) {
    setState(() {
      _searchList.clear();
    });

    if (value.trim().isNotEmpty) {
      setState(() {
        _searchList.addAll(
          ref.watch(eventProvider).where(
                (event) => event.title.toLowerCase().contains(
                      value.toLowerCase(),
                    ),
              ),
        );
      });
    }
  }
}
