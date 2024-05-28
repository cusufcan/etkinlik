import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:etkinlik/feature/profile/widget/profile_image_button.dart';
import 'package:etkinlik/model/my_user.dart';
import 'package:etkinlik/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({
    super.key,
    required this.onChangeTap,
    required this.onDeleteTap,
    required this.isViewOnly,
    this.user,
  });

  final void Function()? onChangeTap;
  final void Function()? onDeleteTap;
  final bool isViewOnly;
  final MyUser? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(AppNum.large),
        child: Column(
          children: [
            Container(
              width: AppNum.sizeXLarge,
              height: AppNum.sizeXLarge,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: FadeInImage(
                placeholder: const AssetImage('assets/gif/loading.gif'),
                image: NetworkImage(
                  user == null
                      ? ref.watch(userProvider).photoURL
                      : user!.photoURL,
                ),
                fit: BoxFit.cover,
              ),
            ),
            if (!isViewOnly) const SizedBox(height: AppNum.medium),
            if (!isViewOnly)
              Row(
                children: [
                  ProfileImageButton(
                    onPressed: onChangeTap,
                    title: 'Değiştir',
                    icon: Icons.edit_outlined,
                    bgColor: Theme.of(context).colorScheme.secondary,
                    fgColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  const SizedBox(width: AppNum.medium),
                  ProfileImageButton(
                    onPressed: onDeleteTap,
                    title: 'Kaldır',
                    icon: Icons.delete_outlined,
                    bgColor: Theme.of(context).colorScheme.error,
                    fgColor: Theme.of(context).colorScheme.onError,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
