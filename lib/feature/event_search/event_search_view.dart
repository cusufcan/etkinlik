import 'package:etkinlik/feature/event_search/widget/event_search_bar.dart';
import 'package:etkinlik/feature/event_search/widget/search_list.dart';
import 'package:etkinlik/model/event.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'event_search_view_model.dart';

class EventSearchView extends ConsumerStatefulWidget {
  const EventSearchView({super.key});

  @override
  ConsumerState<EventSearchView> createState() => _EventSearchViewState();
}

class _EventSearchViewState extends _EventSearchViewModel {
  @override
  Widget build(BuildContext context) {
    Widget list = SearchList(events: _searchList);
    if (_searchList.isEmpty) list = const Text('Etkinlik bulunamadı');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlik Ara'),
      ),
      body: Column(
        children: [
          EventSearchBar(
            onSearchChange: _onSearchChange,
          ),
          const SizedBox(height: 8),
          list,
        ],
      ),
    );
  }
}
