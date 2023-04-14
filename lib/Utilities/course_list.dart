import 'package:flutter/material.dart';

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course List"),
      ),
      body: Container(
        child: Text("Course List"),
      ),
    );
  }
}
