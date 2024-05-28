import 'package:flutter/material.dart';

class ChangeAuthButton extends StatelessWidget {
  const ChangeAuthButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
