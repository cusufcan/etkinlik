import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:flutter/material.dart';

class EventDetailItem extends StatelessWidget {
  const EventDetailItem({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(AppNum.medium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: AppNum.medium),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
            ),
          ),
        ],
      ),
    );
  }
}
