import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/firebase_service.dart';
import 'package:todo_app/home_scree.dart';
import 'package:todo_app/tabs/Authentication/Register_Tab.dart';
import 'package:todo_app/tabs/Authentication/User_Provider.dart';
import 'package:todo_app/tabs/Tasks/default_Button.dart';
import 'package:todo_app/tabs/Tasks/default_TextFormFiled.dart';

class Login_Tap extends StatelessWidget {
  Login_Tap({super.key});
  static const String routename = 'loginTab';
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Image.asset(
                        'assets/images/logo_app.png',
                        width: 140.w,
                        height: 140.h,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login to your Account',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextFiled(
                      taskController: emailcontroller,
                      hint: 'Email',
                      validate: (value) {
                        if (value!.trim().isEmpty) {
                          return '''email address mustn't be empty''';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DefaultTextFiled(
                      taskController: passwordcontroller,
                      ispassword: true,
                      hint: 'Password',
                      validate: (value) {
                        if (value!.trim().isEmpty) {
                          return '''password mustn't be empty''';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    DefaultButton(
                        lable: 'Login',
                        onpress: () async {
                          if (formkey.currentState!.validate()) {
                            await FireBaseService.login(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text)
                                .then((user) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .updateuser(user);
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.reoutename);
                              print('login done');
                            }).catchError((error) {
                              Fluttertoast.showToast(
                                  msg: "Something went wrong!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: AppTheme.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                            });
                          }
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '''Don't have an Account''',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextButton(
                          child: Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppTheme.primary),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Register_Tab.routename);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
