import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:etkinlik/feature/profile/widget/account_field.dart';
import 'package:etkinlik/feature/profile/widget/save_profile_button.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({
    super.key,
    required this.usernameController,
    required this.aboutController,
    required this.isEnabled,
    required this.onSaveTap,
    required this.isViewOnly,
  });

  final TextEditingController usernameController;
  final TextEditingController aboutController;
  final bool isEnabled;
  final void Function()? onSaveTap;
  final bool isViewOnly;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(AppNum.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AccountField(
            controller: usernameController,
            labelText: 'Kullanıcı Adı',
            enabled: isEnabled,
          ),
          const SizedBox(height: AppNum.medium),
          AccountField(
            controller: aboutController,
            labelText: 'Hakkında',
            enabled: isEnabled,
          ),
          const SizedBox(height: AppNum.medium),
          if (!isViewOnly)
            SaveProfileButton(
              onSaveTap: onSaveTap,
              text: isEnabled ? 'Kaydet' : 'Düzenle',
            ),
        ],
      ),
    );
  }
}
