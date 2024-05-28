import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required this.controller,
    required this.onSaved,
  });

  final TextEditingController controller;
  final void Function(String? value) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Şifre',
        suffixIcon: Icon(Icons.lock_outlined),
      ),
      obscureText: true,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'Şifre en az 6 karakter olmalıdır.';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
