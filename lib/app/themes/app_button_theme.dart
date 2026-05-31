import 'package:flutter/material.dart';

class AppButtonTheme {
  const AppButtonTheme._();

  static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      );

  static FloatingActionButtonThemeData floatingActionButtonTheme(
    ColorScheme colorScheme,
  ) => FloatingActionButtonThemeData(
    elevation: 4,
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    shape: CircleBorder(),
  );
}
