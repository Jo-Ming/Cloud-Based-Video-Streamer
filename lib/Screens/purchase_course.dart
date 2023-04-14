import 'package:flutter/material.dart';

import '../Models/Course.dart';

class PurchaseCoursePage extends StatelessWidget {
  final Course course;

  const PurchaseCoursePage({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Course Screen'),
      ),
      body: Container(
        width: 200,
        height: 250,
        child: Center(
          child: Text("user has not yet purchased course."),
        ),
      ),
    );
  }
}
