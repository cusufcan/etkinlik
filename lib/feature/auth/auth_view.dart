import 'dart:io';

import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/helper/messenger.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:etkinlik/feature/auth/widget/index.dart';
import 'package:etkinlik/feature/splash/splash_view.dart';
import 'package:etkinlik/model/my_user.dart';
import 'package:etkinlik/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

part 'auth_view_model.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends _AuthViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_isLogin)
                  Text(
                    'Hoşgeldin',
                    style: GoogleFonts.quicksand(
                      fontSize: AppNum.xSemiLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: AppNum.xSemiLarge),
                CustomCard(
                  padding: const EdgeInsets.all(AppNum.large),
                  margin: const EdgeInsets.symmetric(
                    vertical: AppNum.medium,
                    horizontal: AppNum.large,
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogin)
                          UserImagePicker(
                            onPickImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                        if (!_isLogin) const SizedBox(height: AppNum.small),
                        if (!_isLogin)
                          UsernameInput(
                            controller: _usernameController,
                            onSaved: (newValue) {
                              _username = newValue!;
                            },
                          ),
                        if (!_isLogin) const SizedBox(height: AppNum.small),
                        EmailInput(
                          controller: _emailController,
                          onSaved: (newValue) {
                            _email = newValue!;
                          },
                        ),
                        const SizedBox(height: AppNum.small),
                        PasswordInput(
                          controller: _passwordController,
                          onSaved: (newValue) {
                            _password = newValue!;
                          },
                        ),
                        const SizedBox(height: AppNum.xLarge),
                        if (_isLoading)
                          const SizedBox(
                            width: AppNum.xxLarge,
                            height: AppNum.xxLarge,
                            child: CircularProgressIndicator(),
                          ),
                        if (!_isLoading)
                          LoginButton(
                            onPressed: () => _submit(),
                            text: _isLogin ? 'Giriş Yap' : 'Kayıt Ol',
                          ),
                        if (!_isLoading) const SizedBox(height: AppNum.small),
                        if (!_isLoading)
                          ChangeAuthButton(
                            onPressed: () => _changeAuthMode(),
                            text: _isLogin ? 'Kayıt Ol' : 'Giriş Yap',
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
