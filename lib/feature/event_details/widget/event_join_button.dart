import 'package:etkinlik/base/constant/app_num.dart';
import 'package:flutter/material.dart';

class EventJoinButton extends StatelessWidget {
  const EventJoinButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final void Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppNum.large,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
