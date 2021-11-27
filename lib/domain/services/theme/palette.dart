import 'package:flutter/material.dart';

class Palette {
  static final ThemeData _light = ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: Colors.amber[200]),
      scaffoldBackgroundColor: Colors.amber[50],
      cardTheme: CardTheme(
        color: Colors.yellow[50],
        elevation: 2,
      ),
      chipTheme: ChipThemeData(
          backgroundColor: Colors.amber.withOpacity(0.2),
          disabledColor: Colors.grey,
          selectedColor: Colors.amberAccent,
          secondarySelectedColor: Colors.amberAccent,
          padding: EdgeInsets.zero,
          labelStyle: const TextStyle(color: Colors.grey),
          secondaryLabelStyle: const TextStyle(),
          brightness: Brightness.light),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.amber[100],
          selectedIconTheme: const IconThemeData(color: Colors.orange),
          unselectedIconTheme: const IconThemeData(color: Colors.amberAccent)),
      primarySwatch: Colors.amber);
  static final ThemeData _dark = ThemeData(
      colorScheme: const ColorScheme.dark(), primarySwatch: Colors.deepPurple);

  static ThemeData get light => _light;
  static ThemeData get dark => _dark;
}
