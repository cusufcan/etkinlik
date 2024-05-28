import 'package:etkinlik/base/constant/app_num.dart';
import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppNum.xLarge),
      child: FlutterLogo(
        size: AppNum.sizeLarge,
      ),
    );
  }
}
