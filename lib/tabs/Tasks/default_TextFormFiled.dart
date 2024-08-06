import 'package:flutter/material.dart';
import 'package:todo_app/App_Theme.dart';

class DefaultTextFiled extends StatelessWidget {
  DefaultTextFiled(
      {required this.taskController,
      required this.hint,
      this.maxlines = 1,
      this.validate});
  TextEditingController taskController;
  String hint;
  int maxlines;
  String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: taskController,
      maxLines: maxlines,
      minLines: 1,
      cursorColor: AppTheme.primary,
      validator: validate,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 18,
              color: AppTheme.black.withOpacity(0.6),
            ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.black,
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
