import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData appTheme = _buildAppThemeLight();

ThemeData _buildAppThemeLight() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: Colors.deepOrange,
      secondary: Colors.deepOrange,
      error: Colors.red,
    ),
    scaffoldBackgroundColor: Colors.white,
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.deepOrange,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(),
    ),
    textTheme: _buildAppTextTheme(base.textTheme),
  );
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base.copyWith().apply();
}
