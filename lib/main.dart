import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player_app/Screens/course_page2.dart';
import 'package:video_player_app/Screens/testScreen.dart';
import 'package:video_player_app/Screens/video_info.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/auth_page.dart';
import 'Screens/course_page.dart';
import 'Screens/home_page.dart';
import 'Screens/varify_email_page.dart';
import 'Utilities/LoginWidget.dart';
import 'Utilities/Utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 780),
      builder: (context, child) => ScaffoldMessenger(
        key: Utils.messengerkey,
        child: GetMaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Cloudstream Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: mainLogin(),
        ),
      ),
    );
  }
}

class mainLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.hasError) {
            } else if (snapshot.hasData) {
              if (FirebaseAuth.instance.currentUser!.emailVerified) {
                return CourseListPage();
              } else {
                return AuthPage();
              }
            } else {
              debugPrint('Login attempt failed!');
              return AuthPage();
            }
            return AuthPage();
          },
        ),
      );
}
