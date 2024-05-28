import 'package:flutter/material.dart';

void showMessage(BuildContext context, [String text = 'Bir mesajınız var!']) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Durations.long4,
    ),
  );
}

Future<void> showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String buttonTitle,
  required void Function() onPressed,
  Widget? contentWidget,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: contentWidget ?? Text(content),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: Text(buttonTitle),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
        ],
      );
    },
  );
}
