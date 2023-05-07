import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:video_player_app/Screens/course_page2.dart';
import 'package:video_player_app/Utilities/Utils.dart';
import 'package:flutter/material.dart';

class VarifyEmailPage extends StatefulWidget {
  const VarifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VarifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // user needs to be created before this page is shown.
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      Utils.showSnackBarRed('Verification email sent!', context);
    } catch (e) {
      Utils.showSnackBarRed(e.toString(), context);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    // its important to reload the user to detect changes in status.
    final user = FirebaseAuth.instance.currentUser!;
    await user.reload();
    isEmailVerified = user.emailVerified;

    if (isEmailVerified) {
      timer?.cancel();
      Utils.showSnackBarGreen('Email has been verified!', context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? CourseListPage()
      : Scaffold(
          appBar: AppBar(
            title: Text('Verify Email'),
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verification email has been sent to ${FirebaseAuth.instance.currentUser!.email}.\n\nPlease follow link to verify.',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () async {
                    await sendVerificationEmail();
                  },
                  icon: Icon(Icons.email),
                  label: Text('Resend Verification Email'),
                ),
              ],
            ),
          ),
        );
}
