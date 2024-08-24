import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPrvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String language = 'en';
  SettingsPrvider() {
    loadtheme();
  }
  void changetheme(ThemeMode selectedTheme) {
    themeMode = selectedTheme;
    setThemeprefs();
    notifyListeners();
  }

  Future<void> setThemeprefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isdark', themeMode == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> loadtheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool theme = prefs.getBool('isdark') ?? false;
    themeMode = theme ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
