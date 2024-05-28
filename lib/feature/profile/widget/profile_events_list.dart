import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:etkinlik/feature/event_details/event_details_view.dart';
import 'package:etkinlik/model/event.dart';
import 'package:flutter/material.dart';

class ProfileEventsList extends StatelessWidget {
  const ProfileEventsList({
    super.key,
    required this.events,
  });

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    const Widget emptyWidget = Center(
      child: Text('Gösterilecek veri bulunmamakta.'),
    );

    return CustomCard(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppNum.xSmall),
          bottomRight: Radius.circular(AppNum.xSmall),
        ),
      ),
      child: SizedBox(
        height: 300,
        child: events.isEmpty
            ? emptyWidget
            : ListView.builder(
                itemCount: events.length,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => EventDetailsView(
                                  id: events[index].id,
                                )),
                      );
                    },
                    title: Text(events[index].title),
                    subtitle: Text(
                      events[index].description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        events[index].imageUrl,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
