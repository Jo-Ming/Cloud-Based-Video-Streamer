import 'package:flutter/material.dart';
import '../Utilities/video_player.dart';

class TestScreen extends StatelessWidget {
  final String videoUrl;

  const TestScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Screen'),
      ),
      body: Container(
        width: 200,
        height: 250,
        child: Center(
          child: VideoPlayerWidget(videoUrl: videoUrl),
        ),
      ),
    );
  }
}
