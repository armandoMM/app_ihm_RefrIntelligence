import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;
  static const Color secondary = Colors.deepPurple;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.white;
  static const Color backgroundDark = Colors.grey;
  static final ThemeData ligthTheme = ThemeData.light().copyWith(
      //primary Theme
      primaryColor: primary,
      scaffoldBackgroundColor: Colors.grey[900],
      backgroundColor: primary,
      //AppBar theme
      appBarTheme: const AppBarTheme(color: secondary, elevation: 0),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: AppTheme.secondary),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        elevation: 6,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: secondary,
        shape: const StadiumBorder(),
        elevation: 1,
      )),
      inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: primary),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10), topRight: Radius.circular(10)))));

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    //primary Theme
    primaryColor: primary,
    //AppBar theme
    appBarTheme: const AppBarTheme(color: secondary, elevation: 0),
    scaffoldBackgroundColor: backgroundDark,
  );
}
