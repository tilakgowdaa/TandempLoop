import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;
  bool get dark => isDark;
  late SharedPreferences storeTheme;

  final lightTheme = ThemeData(
      textTheme: const TextTheme(
          titleMedium:
              TextStyle(fontSize: 17, color: Color.fromARGB(255, 32, 31, 31)),
          titleLarge: TextStyle(
              color: Color.fromARGB(255, 245, 242, 242),
              fontSize: 33,
              fontFamily: 'DMSerifDisplay',
              fontStyle: FontStyle.italic),
          titleSmall: TextStyle(
              color: Color.fromARGB(255, 245, 242, 242),
              fontSize: 16,
              fontFamily: 'Inconsolata'),
          bodyLarge: TextStyle(),
          headlineMedium: TextStyle(
              fontSize: 22,
              fontFamily: '.SF UI TEXT',
              color: Color.fromARGB(255, 245, 242, 242),
              fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Inconsolata',
              decoration: TextDecoration.underline,
              decorationColor: Colors.white),
          labelMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color.fromARGB(255, 13, 18, 99))),
      primaryColor: const Color.fromARGB(255, 245, 242, 242),
      primaryColorDark: const Color.fromARGB(255, 87, 84, 84),
      scaffoldBackgroundColor: Colors.transparent,
      cardColor: Colors.white,
      canvasColor: Color.fromARGB(190, 185, 199, 246),
      primaryColorLight: const Color.fromARGB(156, 25, 178, 205));

  final darkTheme = ThemeData(
      textTheme: const TextTheme(
          titleMedium:
              TextStyle(fontSize: 17, color: Color.fromARGB(255, 5, 5, 5)),
          titleLarge: TextStyle(
              color: Color.fromARGB(215, 182, 190, 160),
              fontSize: 33,
              fontFamily: 'DMSerifDisplay',
              fontStyle: FontStyle.italic),
          titleSmall: TextStyle(
              color: Color.fromARGB(215, 182, 190, 160),
              fontSize: 16,
              fontFamily: 'Inconsolata'),
          bodyLarge: TextStyle(),
          headlineMedium: TextStyle(
              fontSize: 22,
              fontFamily: '.SF UI TEXT',
              color: Color.fromARGB(215, 182, 190, 160),
              fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(
              color: Color.fromARGB(215, 182, 190, 160),
              fontSize: 16,
              fontFamily: 'Inconsolata',
              decoration: TextDecoration.underline,
              decorationColor: Colors.white),
          labelMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color.fromARGB(255, 108, 115, 244))),
      primaryColor: const Color.fromARGB(215, 182, 190, 160),
      primaryColorDark: const Color.fromARGB(255, 8, 8, 8),
      scaffoldBackgroundColor: const Color.fromARGB(255, 28, 44, 52),
      cardColor: Color.fromARGB(255, 68, 69, 69),
      canvasColor: Color.fromARGB(251, 46, 46, 46),
      primaryColorLight: const Color.fromARGB(255, 36, 5, 98));

  changeTheme() {
    isDark = !dark;
    storeTheme.setBool("isDark", isDark);
    notifyListeners();
  }

  init() async {
    storeTheme = await SharedPreferences.getInstance();
    isDark = storeTheme.getBool("isDark") ?? false;
    notifyListeners();
  }
}
