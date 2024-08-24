import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/tabs/Settings/Settings_Provider.dart';

class DefaultTextFiled extends StatefulWidget {
  DefaultTextFiled(
      {required this.taskController,
      required this.hint,
      this.maxlines = 1,
      this.ispassword = false,
      this.validate});
  TextEditingController taskController;
  String hint;
  int maxlines;
  bool ispassword;
  String? Function(String?)? validate;

  @override
  State<DefaultTextFiled> createState() => _DefaultTextFiledState();
}

class _DefaultTextFiledState extends State<DefaultTextFiled> {
  bool showpass = true;

  @override
  Widget build(BuildContext context) {
    SettingsPrvider settingsPrvider = Provider.of<SettingsPrvider>(context);
    return TextFormField(
      controller: widget.taskController,
      style: TextStyle(color: settingsPrvider.themeMode == ThemeMode.dark ? AppTheme.white : AppTheme.black,),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.ispassword ? showpass : false,
      maxLines: widget.maxlines,
      minLines: 1,
      cursorColor: AppTheme.primary,
      validator: widget.validate,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: widget.ispassword
            ? IconButton(
                icon: Icon(showpass
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                onPressed: () {
                  showpass = !showpass;
                  setState(() {});
                },
              )
            : null,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 18,
              color: settingsPrvider.themeMode == ThemeMode.dark
                  ? AppTheme.white.withOpacity(0.6)
                  : AppTheme.black.withOpacity(0.6),
            ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: settingsPrvider.themeMode == ThemeMode.dark
                ? AppTheme.primary
                : AppTheme.black,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary, width: 2.5),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
