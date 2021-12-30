import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Palette {
  static final ThemeData _light = ThemeData(
      textTheme: GoogleFonts.ubuntuTextTheme(),
      appBarTheme: AppBarTheme(backgroundColor: Colors.amber[200]),
      cardTheme: CardTheme(
        color: Colors.yellow[100],
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
      fontFamily: GoogleFonts.poppins().fontFamily,
      colorScheme: const ColorScheme.dark(),
      primarySwatch: Colors.deepPurple);

  static ThemeData get light => _light;
  static ThemeData get dark => _dark;
}
