// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeStyles {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFF2F4F7),
    dividerTheme: DividerThemeData(color: Color(0xffEAECF0)),
    primaryColor: const Color(0xff9B2620),
    brightness: Brightness.light,
    dividerColor: Colors.white60,
    highlightColor: const Color(0xFF344054),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Roboto', fontSize: 42, fontWeight: FontWeight.w600),
      displayMedium: TextStyle(fontFamily: 'Roboto', fontSize: 28, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(fontFamily: "Roboto", fontSize: 14),
    ),
    indicatorColor: Colors.white,
    cardColor: const Color(0xFFF9FAFB),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.light,
    )
        .copyWith(
          secondary: const Color(0xff896277),
          brightness: Brightness.light,
        )
        .copyWith(background: Colors.white)
        .copyWith(background: Color(0xffEAECF0)),
  );

  // -------------Dark Theme--------------
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xff121212),
      primaryColor: const Color(0xff896277),
      dividerTheme: DividerThemeData(color: Color(0xffEAECF0)),
      brightness: Brightness.dark,
      dividerColor: Colors.black12,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Roboto', fontSize: 42, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(fontFamily: 'Roboto', fontSize: 28, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.w600),
        bodySmall: TextStyle(fontFamily: "Roboto", fontSize: 14),
      ),
      indicatorColor: Color(0xFF282828),
      highlightColor: Colors.white,
      cardColor: const Color(0xFF282828),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
      )
          .copyWith(
            secondary: const Color(0xff896277),
            brightness: Brightness.dark,
          )
          .copyWith(background: Colors.black)
          .copyWith(background: Color(0xFFF2F4F7).withOpacity(0.2)));
}
