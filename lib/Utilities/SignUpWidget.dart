import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/course_page2.dart';
import '../Screens/home_page.dart';
import '../Screens/varify_email_page.dart';
import '../colors.dart' as color;
import '../main.dart';
import 'Utils.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpWidget({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isObscured = true;

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.darkGrey,
      appBar: AppBar(
        title: Text("Sign Up Page"),
        backgroundColor: color.AppColor.black,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80.h),
              child: Center(
                child: Container(
                  width: 200.w,
                  height: 150.h,
                  child: Image.asset('assets/simpleXstrong.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: color.AppColor.lightGrey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color.AppColor.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color.AppColor.orange),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Email is required.';
                  } else if (!EmailValidator.validate(email)) {
                    return 'Not a valid email.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: TextFormField(
                controller: _passwordController,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: color.AppColor.lightGrey),
                  suffixIcon: IconButton(
                    onPressed: _toggleObscureText,
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: color.AppColor.lightGrey,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color.AppColor.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color.AppColor.orange),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _validatePassword,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: color.AppColor.lightGrey),
                  suffixIcon: IconButton(
                    onPressed: _toggleObscureText,
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: color.AppColor.lightGrey,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color.AppColor.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color.AppColor.orange),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _validatePassword,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.h),
              child: SizedBox(
                  height: 50.h,
                  width: 300.w,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      debugPrint("User tapped on sign up button");
                      signUp();
                    },
                    icon: Icon(Icons.person_add),
                    label: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color.AppColor.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
                      textStyle: TextStyle(fontSize: 15.sp),
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(10.h),
              child: SizedBox(
                height: 50.h,
                width: 300.w,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                          color: color.AppColor.white, fontSize: 15.sp),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: color.AppColor.orange,
                            fontSize: 15.sp,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //TODO SIGN UP SCREEN GOES HERE
                              debugPrint("User tapped on sign up button");
                              widget.onClickedSignIn();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) => Get.offAll(() => VarifyEmailPage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Utils.showSnackBarRed(
            'The email address is already in use by another account.', context);
      }
    } catch (e) {
      debugPrint("Error: $e");
      print(e);
      Utils.showSnackBarRed(e.toString(), context);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  String? _validatePassword(String? value) {
    if (value != null && value.length < 6) {
      return 'Must be at least 6 characters long.';
    } else if (value != _confirmPasswordController.text) {
      return 'Passwords do not match.';
    } else {
      return null;
    }
  }
}
