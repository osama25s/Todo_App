import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/tabs/Settings/Settings_Provider.dart';

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
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppTheme.white, fontSize: 25.sp),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mode',
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
                  borderRadius: BorderRadius.circular(4),
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
                          'Light Mode',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(
                          'dark Mode',
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
                height: 52,
              ),
              Text(
                'Language',
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
                  borderRadius: BorderRadius.circular(4),
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
                          'English',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    DropdownMenuItem(
                        value: 'ar',
                        child: Text(
                          'Arabic',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  ],
                  onChanged: (value) {},
                  dropdownColor: settingsPrvider.themeMode == ThemeMode.dark
                      ? AppTheme.darkitems
                      : AppTheme.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
