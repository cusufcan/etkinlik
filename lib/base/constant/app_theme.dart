import 'package:etkinlik/base/constant/app_num.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) => ThemeData.light().copyWith(
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppNum.xSmall),
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppNum.xSmall),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppNum.xSmall),
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppNum.xSmall),
        ),
      ),
    );

ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppNum.xSmall),
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppNum.xSmall),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppNum.xSmall),
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppNum.xSmall),
        ),
      ),
    );
