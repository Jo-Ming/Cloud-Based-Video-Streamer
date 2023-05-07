import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/course_page2.dart';
import '../Screens/forgot_password_page.dart';
import '../Screens/home_page.dart';
import '../colors.dart' as color;
import '../main.dart';
import 'Utils.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
        title: Text("Login Page"),
        backgroundColor: color.AppColor.black,
      ),
      body: SingleChildScrollView(
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
              child: TextField(
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
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: TextField(
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
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.h),
              child: SizedBox(
                height: 50.h,
                width: 300.w,
                child: ElevatedButton(
                  onPressed: () async {
                    debugPrint("User tapped on login button");
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Center(
                              child: CircularProgressIndicator(),
                            ));
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      // Navigate to the CourseListPage if the user signs in successfully.
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CourseListPage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      print(e);
                      Utils.showSnackBarRed(e.message, context);
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.AppColor.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, color: color.AppColor.white),
                      SizedBox(width: 10.w),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: color.AppColor.white,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1.h),
              child: SizedBox(
                  height: 35.h,
                  width: 300.w,
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            color: color.AppColor.white, fontSize: 15.sp),
                        children: [
                          TextSpan(
                            text: 'Forgot Password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: color.AppColor.orange,
                              fontSize: 15.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                debugPrint("User tapped on forgot password");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ForgotPasswordPage()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(1.h),
              child: SizedBox(
                  height: 25.h,
                  width: 300.w,
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            color: color.AppColor.white, fontSize: 15.sp),
                        children: [
                          TextSpan(text: 'No account? '),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: color.AppColor.orange,
                              fontSize: 15.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //TODO SIGN UP SCREEN GOES HERE
                                debugPrint("User tapped on sign up button");
                                widget.onClickedSignUp();
                              },
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
