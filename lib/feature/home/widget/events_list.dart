import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/events_list_item.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsList extends ConsumerWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.separated(
        itemCount: ref.watch(eventProvider).length,
        separatorBuilder: (ctx, index) {
          return const SizedBox(height: AppNum.xSmall);
        },
        itemBuilder: (ctx, index) {
          return EventsListItem(
            id: ref.watch(eventProvider).elementAt(index).id,
          );
        },
      ),
    );
  }
}
