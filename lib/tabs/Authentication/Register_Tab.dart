import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App_Theme.dart';
import 'package:todo_app/firebase_service.dart';
import 'package:todo_app/home_scree.dart';
import 'package:todo_app/tabs/Authentication/Login_Tab.dart';
import 'package:todo_app/tabs/Authentication/User_Provider.dart';
import 'package:todo_app/tabs/Tasks/default_Button.dart';
import 'package:todo_app/tabs/Tasks/default_TextFormFiled.dart';

class Register_Tab extends StatelessWidget {
  Register_Tab({super.key});
  static const String routename = 'registerTab';
  TextEditingController namecontroller = TextEditingController();
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
                      'Register Now',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextFiled(
                      taskController: namecontroller,
                      hint: 'Name',
                      validate: (value) {
                        if (value == null || value.trim().length < 3) {
                          return 'name can not less tahn 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
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
                        lable: 'Create Account',
                        onpress: () {
                          if (formkey.currentState!.validate()) {
                            FireBaseService.register(
                                    name: namecontroller.text,
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text)
                                .then((User) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .updateuser(User);
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.reoutename);
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
                          'Already have an account?',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextButton(
                          child: Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppTheme.primary),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Login_Tap.routename);
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
