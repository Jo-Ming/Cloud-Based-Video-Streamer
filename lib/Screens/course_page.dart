import 'dart:convert';

import 'package:flutter/material.dart';

class Course {
  final String title;
  final String description;
  final String time;
  final String price;
  final String thumbnail;
  final List<Video> videoList;

  Course({
    required this.title,
    required this.description,
    required this.time,
    required this.price,
    required this.thumbnail,
    required this.videoList,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      description: json['description'],
      time: json['time'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      videoList: (json['videoList'] as List<dynamic>)
          .map((videoJson) => Video.fromJson(videoJson))
          .toList(),
    );
  }
}

class Video {
  final String title;
  final String description;
  final String time;
  final String thumbnail;
  final String videoUrl;

  Video({
    required this.title,
    required this.description,
    required this.time,
    required this.thumbnail,
    required this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'],
      description: json['description'],
      time: json['time'],
      thumbnail: json['thumbnail'],
      videoUrl: json['videoUrl'],
    );
  }
}

class CourseTile extends StatelessWidget {
  final Course course;
  const CourseTile({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(course.thumbnail),
      title: Text(course.title),
      subtitle: Text(course.description),
      trailing: Text(course.time),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(course: course),
          ),
        );
      },
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: ListView.builder(
        itemCount: course.videoList.length,
        itemBuilder: (context, index) {
          final video = course.videoList[index];
          return ListTile(
            leading: Image.network(video.thumbnail),
            title: Text(video.title),
            subtitle: Text(video.description),
            trailing: Text(video.time),
            onTap: () {
              // TODO: Navigate to video player page
            },
          );
        },
      ),
    );
  }
}

class CoursePage extends StatelessWidget {
  final List<Course> courses;

  const CoursePage({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final course = courses[index];
                return CourseTile(course: course);
              },
              childCount: courses.length,
            ),
          ),
        ],
      ),
    );
  }
}
