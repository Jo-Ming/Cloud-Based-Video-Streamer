import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../Models/Course.dart';
import '../Utilities/course_tile.dart';

class CourseListPage extends StatefulWidget {
  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<Course> courseList = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    var res =
        await DefaultAssetBundle.of(context).loadString("json/courseinfo.json");
    var resInfo = json.decode(res);
    //print(resInfo);
    setState(() {
      courseList = List<Course>.from(resInfo.map((x) => Course.fromJson(x)));
    });
    print(courseList[0].videoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course List"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("user@example.com"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("Purchases"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help & Feedback"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/simpleXstrong.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: courseList.length,
                itemBuilder: (BuildContext context, int index) {
                  Course course = courseList[index];
                  return CourseTile(
                    course: course,
                    isPurchased: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
