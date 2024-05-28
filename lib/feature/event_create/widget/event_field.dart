import 'package:flutter/material.dart';

class EventField extends StatelessWidget {
  const EventField({
    super.key,
    required this.label,
    required this.onSaved,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.enabled,
  });

  final String label;
  final void Function(String? value) onSaved;
  final String? Function(String? value)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        enabled: enabled ?? true,
        labelText: label,
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
