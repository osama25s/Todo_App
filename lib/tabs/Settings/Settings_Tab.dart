import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/firebase_service.dart';
import 'package:todo_app/tabs/Authentication/Login_Tab.dart';
import 'package:todo_app/tabs/Authentication/User_Provider.dart';
import 'package:todo_app/tabs/Settings/Settings_Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/tabs/Tasks/tasks_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsPrvider settingsPrvider = Provider.of<SettingsPrvider>(context);
    return Column(
      children: [
        Stack(children: [
          Container(
            width: double.infinity,
            height: 220.h,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 75.h, start: 20.w),
            child: Text(
              AppLocalizations.of(context)!.settings,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppTheme.white, fontSize: 25.sp),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.mode,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: settingsPrvider.themeMode == ThemeMode.dark
                      ? AppTheme.darkitems
                      : AppTheme.white,
                  border: Border.all(color: AppTheme.primary),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DropdownButton<ThemeMode>(
                  value: settingsPrvider.themeMode,
                  iconEnabledColor: settingsPrvider.themeMode == ThemeMode.dark
                      ? AppTheme.white
                      : AppTheme.black,
                  isExpanded: true,
                  underline: Container(),
                  items: [
                    DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(
                          AppLocalizations.of(context)!.lightmode,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(
                          AppLocalizations.of(context)!.darkmode,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      settingsPrvider.changetheme(value);
                    }
                  },
                  dropdownColor: settingsPrvider.themeMode == ThemeMode.dark
                      ? AppTheme.darkitems
                      : AppTheme.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: settingsPrvider.themeMode == ThemeMode.dark
                      ? AppTheme.darkitems
                      : AppTheme.white,
                  border: Border.all(color: AppTheme.primary),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DropdownButton(
                  value: settingsPrvider.language,
                  iconEnabledColor: settingsPrvider.themeMode == ThemeMode.dark
                      ? AppTheme.white
                      : AppTheme.black,
                  isExpanded: true,
                  underline: Container(),
                  items: [
                    DropdownMenuItem(
                        value: 'en',
                        child: Text(
                          AppLocalizations.of(context)!.english,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    DropdownMenuItem(
                        value: 'ar',
                        child: Text(
                          AppLocalizations.of(context)!.arabic,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      settingsPrvider.changelanguage(value);
                    }
                  },
                  dropdownColor: settingsPrvider.themeMode == ThemeMode.dark
                      ? AppTheme.darkitems
                      : AppTheme.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              InkWell(
                onTap: () {
                  FireBaseService.logout();
                  Navigator.of(context)
                      .pushReplacementNamed(Login_Tap.routename);
                  Provider.of<TasksProvider>(context, listen: false)
                      .tasks
                      .clear();
                  Provider.of<UserProvider>(context, listen: false)
                      .currentUser = null;
                },
                child: Container(
                  width: double.infinity,
                  height: 55.h,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: settingsPrvider.themeMode == ThemeMode.dark
                        ? AppTheme.darkitems
                        : AppTheme.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppTheme.red),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.logout,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 20,
                                  color: AppTheme.red,
                                ),
                      ),
                      Icon(
                        Icons.logout,
                        color: AppTheme.red,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
