import 'package:flutter/material.dart';

class AccountField extends StatelessWidget {
  const AccountField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.enabled,
  });

  final TextEditingController controller;
  final bool enabled;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabled: enabled,
        labelText: labelText,
      ),
    );
  }
}
