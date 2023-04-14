import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player_app/Screens/video_info.dart';
import '../colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Info> info = [];
  _initData() async {
    var res = await DefaultAssetBundle.of(context).loadString("json/info.json");
    var resInfo = json.decode(res);
    setState(() {
      info = List<Info>.from(resInfo.map((x) => Info.fromJson(x)));
    });
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: color.AppColor.black,
      ),
      backgroundColor: color.AppColor.darkGrey,
      body: CustomScrollView(slivers: [
        SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0.h,
              horizontal: 30.w,
            ),
            sliver: SliverToBoxAdapter(
                child: Container(
              width: 400,
              height: 60,
              child: Row(
                children: [
                  Text(
                    "The Forge",
                    style: TextStyle(
                        fontSize: 30,
                        color: color.AppColor.white,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ))),
        SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 25.h,
              horizontal: 30.w,
            ),
            sliver: SliverToBoxAdapter(
                child: Row(
              children: [
                Text(
                  "Training",
                  style: TextStyle(
                      fontSize: 20,
                      color: color.AppColor.white,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                InkWell(
                    onTap: () {
                      Get.to(() => VideoInfo());
                    },
                    child: Row(
                      children: [
                        Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.white,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.arrow_forward,
                            size: 25, color: color.AppColor.white)
                      ],
                    ))
              ],
            ))),
        SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0.w,
              horizontal: 30.w,
            ),
            sliver: SliverToBoxAdapter(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    color.AppColor.black.withOpacity(0.8),
                    color.AppColor.darkGrey.withOpacity(0.9),
                  ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(5, 10),
                        blurRadius: 20,
                        color: color.AppColor.black.withOpacity(0.2))
                  ]),
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next lesson:",
                      style:
                          TextStyle(fontSize: 16, color: color.AppColor.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Kettlebell Swings",
                      style:
                          TextStyle(fontSize: 25, color: color.AppColor.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "and Deadlifts",
                      style:
                          TextStyle(fontSize: 25, color: color.AppColor.white),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer,
                                size: 20, color: color.AppColor.white),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "30 min",
                              style: TextStyle(
                                  fontSize: 14, color: color.AppColor.white),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: [
                                BoxShadow(
                                    color: color.AppColor.white,
                                    blurRadius: 10,
                                    offset: Offset(4, 8))
                              ]),
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 60,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ))),
        SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0.w,
              horizontal: 30.w,
            ),
            sliver: SliverToBoxAdapter(
                child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 30),
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("assets/card.jpg"),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 40,
                              offset: Offset(8, 10),
                              color: color.AppColor.darkGrey.withOpacity(0.3)),
                          BoxShadow(
                              blurRadius: 10,
                              offset: Offset(-1, -5),
                              color: color.AppColor.darkGrey.withOpacity(0.3))
                        ]),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(right: 200, bottom: 30),
                    decoration: BoxDecoration(
                      // color:Colors.redAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage("assets/figure.png"),
                        //fit:BoxFit.fill
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 100,
                    margin: const EdgeInsets.only(left: 150, top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You are doing great",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color.AppColor.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Keep it up\n",
                                style: TextStyle(
                                  color: color.AppColor.white,
                                  fontSize: 16,
                                ),
                                children: [
                              TextSpan(text: "stick to your plan")
                            ]))
                      ],
                    ),
                  )
                ],
              ),
            ))),
        SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0.w,
              horizontal: 30.w,
            ),
            sliver: SliverToBoxAdapter(
                child: Container(
              child: Text(
                "My Courses",
                //textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: color.AppColor.white),
              ),
            ))),
        SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 25.h,
              horizontal: 30.w,
            ),
            sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.6,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      height: 170.h,
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(info.elementAt(index).img ?? ""),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                offset: Offset(5, 5),
                                color:
                                    color.AppColor.darkGrey.withOpacity(0.1)),
                            BoxShadow(
                                blurRadius: 3,
                                offset: Offset(-5, -5),
                                color: color.AppColor.darkGrey.withOpacity(0.1))
                          ]),
                      child: Center(
                        child: Align(
                          child: Text(info.elementAt(index).title ?? "",
                              style: TextStyle(
                                  fontSize: 20, color: color.AppColor.white)),
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    );
                  },
                  childCount: info.length,
                ))),
      ]),
    ));
  }
}

class Info {
  String? title;
  String? img;

  Info({
    this.title,
    this.img,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        title: json["title"],
        img: json["img"],
      );
}
