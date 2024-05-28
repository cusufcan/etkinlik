import 'package:flutter/material.dart';

class SearchActionButton extends StatelessWidget {
  const SearchActionButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final void Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
    );
  }
}
