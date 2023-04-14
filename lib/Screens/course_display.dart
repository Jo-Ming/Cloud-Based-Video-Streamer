import 'package:flutter/material.dart';
import '../Models/Course.dart';
import '../Utilities/video_player.dart';
import '../Utilities/video_tile.dart';

class CourseDisplayPage extends StatelessWidget {
  final Course course;

  const CourseDisplayPage({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: VideoPlayerWidget(videoUrl: course.videoList[0].videoUrl),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              course.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: course.videoList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(),
                          body: VideoPlayerWidget(
                            videoUrl: course.videoList[index].videoUrl,
                          ),
                        ),
                      ),
                    );
                  },
                  child: VideoTile(
                    video: course.videoList[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
