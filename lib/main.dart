// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/home_scree.dart';
import 'package:todo_app/tabs/Authentication/Login_Tab.dart';
import 'package:todo_app/tabs/Authentication/Register_Tab.dart';
import 'package:todo_app/tabs/Authentication/User_Provider.dart';
import 'package:todo_app/tabs/Settings/Settings_Provider.dart';
import 'package:todo_app/tabs/Tasks/EditTask_Tab.dart';
import 'package:todo_app/tabs/Tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TasksProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SettingsPrvider()),
      ],
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsPrvider settingsPrvider = Provider.of<SettingsPrvider>(context);
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: settingsPrvider.themeMode,
        routes: {
          HomeScreen.reoutename: (context) => HomeScreen(),
          EditTask_Tab.routname: (context) => EditTask_Tab(),
          Login_Tap.routename: (context) => Login_Tap(),
          Register_Tab.routename: (context) => Register_Tab(),
        },
        initialRoute: Login_Tap.routename,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(settingsPrvider.language),
      ),
    );
  }
}
