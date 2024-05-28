import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/helper/messenger.dart';
import 'package:etkinlik/feature/home/widget/events_list.dart';
import 'package:etkinlik/feature/home/widget/go_create_event_button.dart';
import 'package:etkinlik/feature/home/widget/go_search_event_button.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.watch(eventProvider.notifier).fetchEvents().then(
          (_) {
            if (ref.read(eventProvider).isEmpty) {
              showMessage(context, 'Gösterilecek etkinlik yok.');
            }
          },
        );
      },
      child: const Padding(
        padding: EdgeInsets.all(AppNum.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                GoCreateEventButton(),
                SizedBox(width: AppNum.medium),
                GoSearchEventButton(),
              ],
            ),
            SizedBox(height: AppNum.medium),
            EventsList(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
