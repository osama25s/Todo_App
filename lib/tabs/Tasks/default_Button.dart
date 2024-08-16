import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/App_Theme.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({required this.lable, required this.onpress});
  VoidCallback onpress;
  String lable;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        lable,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500, color: AppTheme.white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 52.h)),
      onPressed: onpress,
    );
  }
}
