import 'dart:io';

import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/constant/app_string.dart';
import 'package:etkinlik/base/helper/messenger.dart';
import 'package:etkinlik/feature/auth/auth_view.dart';
import 'package:etkinlik/feature/profile/widget/account_information.dart';
import 'package:etkinlik/feature/profile/widget/delete_account_button.dart';
import 'package:etkinlik/feature/profile/widget/profile_image.dart';
import 'package:etkinlik/feature/profile/widget/user_information.dart';
import 'package:etkinlik/model/my_user.dart';
import 'package:etkinlik/provider/event_provider.dart';
import 'package:etkinlik/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_view_model.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({
    this.isViewOnly = false,
    this.user,
    super.key,
  });

  final bool isViewOnly;
  final MyUser? user;

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends _ProfileViewModel
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(userProvider.notifier).fetchUser();
        await ref.read(eventProvider.notifier).fetchEvents();
        setState(() {
          _usernameController.text = ref.watch(userProvider).name;
          _aboutController.text = ref.watch(userProvider).about;
        });
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppNum.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileImage(
              onChangeTap:
                  !_imageLock ? () async => await _changeProfileImage() : null,
              onDeleteTap: !_imageLock &&
                      ref.watch(userProvider).photoURL !=
                          _appString.defaultPPUrl
                  ? () => _deleteProfileImage()
                  : null,
              isViewOnly: widget.isViewOnly,
              user: widget.user,
            ),
            const SizedBox(height: AppNum.small),
            AccountInformation(
              usernameController: _usernameController,
              aboutController: _aboutController,
              isEnabled: _isEditEnabled,
              onSaveTap: !_editLock ? () => _onSaveTap() : null,
              isViewOnly: widget.isViewOnly,
            ),
            if (!widget.isViewOnly) const SizedBox(height: AppNum.small),
            if (!widget.isViewOnly) const UserInformation(),
            if (!widget.isViewOnly) const SizedBox(height: AppNum.small),
            if (!widget.isViewOnly)
              DeleteAccountButton(
                onDeleteTap: !_imageLock ? () => _deleteAccount() : null,
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
