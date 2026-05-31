import 'package:flutter/material.dart';
import 'package:minimal_todo_journal/app/app_button_theme.dart';
import 'package:minimal_todo_journal/app/app_colors.dart';
import 'package:minimal_todo_journal/app/app_text_theme.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.light(
      primary: AppColors.softBlack,
      onPrimary: AppColors.softWhite,
      surface: AppColors.softWhite,
      onSurface: AppColors.softBlack,
      onSurfaceVariant: AppColors.mediumGray,
      outline: AppColors.lightGray,
    );

    return _theme(colorScheme);
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.softWhite,
      onPrimary: AppColors.softBlack,
      surface: AppColors.softBlack,
      onSurface: AppColors.softWhite,
      onSurfaceVariant: AppColors.silverGray,
      outline: AppColors.slateGray,
    );
    return _theme(colorScheme);
  }

  static ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    fontFamily: 'Lora',
    scaffoldBackgroundColor: colorScheme.surface,
    colorScheme: colorScheme,
    textTheme: AppTextTheme.theme(colorScheme),
    elevatedButtonTheme: AppButtonTheme.elevatedButtonTheme(colorScheme),
    floatingActionButtonTheme: AppButtonTheme.floatingActionButtonTheme(
      colorScheme,
    ),
  );
}
