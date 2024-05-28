import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:flutter/material.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({
    super.key,
    required this.onDeleteTap,
  });

  final void Function()? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(AppNum.large),
      child: ElevatedButton.icon(
        onPressed: onDeleteTap,
        icon: const Icon(Icons.delete_forever_outlined),
        label: const Text('Hesabı Sil'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error,
          foregroundColor: Theme.of(context).colorScheme.onError,
        ),
      ),
    );
  }
}
