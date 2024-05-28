import 'package:etkinlik/base/constant/app_num.dart';
import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  const EventButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.maxLines = 1,
  });

  final String label;
  final void Function()? onPressed;
  final Icon? icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppNum.small,
        ),
        child: Text(
          label,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
