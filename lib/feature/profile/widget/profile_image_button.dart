import 'package:flutter/material.dart';

class ProfileImageButton extends StatelessWidget {
  const ProfileImageButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
    required this.bgColor,
    required this.fgColor,
  });

  final String title;
  final IconData icon;
  final Color bgColor;
  final Color fgColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
        ),
      ),
    );
  }
}
