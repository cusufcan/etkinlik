import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:etkinlik/feature/notifications/widget/approve_button.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.title,
    required this.body,
    required this.onAccept,
    required this.onReject,
  });

  final String title;
  final String body;
  final void Function() onAccept;
  final void Function() onReject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppNum.xSmall),
              topRight: Radius.circular(AppNum.xSmall),
            ),
          ),
          child: ListTile(
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              body,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppNum.xSmall),
                topRight: Radius.circular(AppNum.xSmall),
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            NotificationButton(
              title: 'Kabul Et',
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppNum.xSmall),
              ),
              color: Theme.of(context).colorScheme.primaryContainer,
              onTap: onAccept,
            ),
            NotificationButton(
              title: 'Reddet',
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(AppNum.xSmall),
              ),
              color: Theme.of(context).colorScheme.errorContainer,
              onTap: onReject,
            ),
          ],
        ),
      ],
    );
  }
}
