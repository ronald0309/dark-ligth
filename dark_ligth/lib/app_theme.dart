import 'package:flutter/material.dart';

class ThemeProvider {
  bool isLightTheme;
  ThemeProvider({required this.isLightTheme});

  ThemeData themeData() {
    return ThemeData(
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
    );
  }
}
