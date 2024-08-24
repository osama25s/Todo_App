import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPrvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String language = 'en';
  SettingsPrvider() {
    loadprefs();
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

  Future<void> loadprefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool theme = prefs.getBool('isdark') ?? false;
    themeMode = theme ? ThemeMode.dark : ThemeMode.light;
    final String lang = prefs.getString("language") ?? 'en';
    language = lang;
    notifyListeners();
  }

  void changelanguage(String selectedlang) async {
    language = selectedlang;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", selectedlang);
  }
}
