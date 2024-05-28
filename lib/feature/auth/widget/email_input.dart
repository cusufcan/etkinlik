import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
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
        labelText: 'E-posta',
        suffixIcon: Icon(Icons.email_outlined),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null ||
            value.trim().isEmpty ||
            !value.contains('@') ||
            !value.contains('.') ||
            value.length < 5) {
          return 'Geçerli bir e-posta adresi giriniz.';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
