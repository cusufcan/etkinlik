import 'package:etkinlik/base/helper/messenger.dart';
import 'package:etkinlik/feature/auth/auth_view.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:etkinlik/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const UserAppBar({super.key});

  void _signOutTap(BuildContext context, WidgetRef ref) {
    showCustomAlertDialog(
      context: context,
      title: 'Çıkış Yap',
      content: 'Çıkış yapmak istediğinize emin misiniz?',
      buttonTitle: 'Evet',
      onPressed: () async {
        await _signOut(ref).then((value) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration.zero,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AuthView(),
            ),
          );
        });
      },
    );
  }

  Future<void> _signOut(WidgetRef ref) async {
    await ref.read(userProvider.notifier).signOutUser();
    ref.read(eventProvider.notifier).resetEvents();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('Etkinlik'),
      actions: [
        IconButton(
          onPressed: () => _signOutTap(context, ref),
          tooltip: 'Çıkış Yap',
          icon: Icon(
            Icons.exit_to_app_outlined,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
