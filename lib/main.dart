import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player_app/Screens/course_page2.dart';
import 'package:video_player_app/Screens/testScreen.dart';
import 'package:video_player_app/Screens/video_info.dart';

import 'Screens/course_page.dart';
import 'Screens/home_page.dart';
import 'Screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 780),
        builder: (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Forge Demo',
            theme: ThemeData(
              brightness: Brightness.dark,
            ),
            home: CourseListPage()));
  }
}
