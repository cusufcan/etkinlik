import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/events_list_item.dart';
import 'package:etkinlik/model/event.dart';
import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  const SearchList({
    super.key,
    required this.events,
  });

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (ctx, index) {
          return const SizedBox(height: 8);
        },
        padding: const EdgeInsets.symmetric(
          horizontal: AppNum.small,
        ),
        itemCount: events.length,
        itemBuilder: (ctx, index) {
          return EventsListItem(
            id: events[index].id,
          );
        },
      ),
    );
  }
}
