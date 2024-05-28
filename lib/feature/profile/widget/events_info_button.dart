import 'package:flutter/material.dart';

class EventsInfoButton extends StatelessWidget {
  const EventsInfoButton({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.text,
    required this.borderRadius,
  });

  final void Function() onTap;
  final bool isActive;
  final String text;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            side: isActive
                ? BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 2,
                  )
                : BorderSide.none,
            borderRadius: borderRadius,
          ),
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
