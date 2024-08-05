import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static Color primary = Color(0xFF5D9CEC);
  static Color lightBG = Color(0xffDFECDB);
  static Color green = Color(0xff61E757);
  static Color red = Color(0xffEC4B4B);
  static Color black = Color(0xff383838);
  static Color white = Color(0xFFFFFFFF);
  static Color grey = Color(0xffC8C9CB);
  static Color darkBG = Color(0xff060E1E);
  static Color darkitems = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: lightBG,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primary,
      unselectedItemColor: grey,
      backgroundColor: white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(
          width: 4,
          color: white,
        ),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
