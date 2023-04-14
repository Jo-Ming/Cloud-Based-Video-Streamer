import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List<Video> videoList = [];
  bool _playArea = false;
  bool _isPlaying = true;
  bool _disposed = false;
  int _isPlayingIndex = 0;
  String _curPos = "";
  String _totalPos = "";
  String _videoTime = "00:00";
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  ChewieController? chewieController;

  _initData() async {
    if (_controller != null) {
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
      _controller = null;
    }
    if (_initializeVideoPlayerFuture != null) {
      _initializeVideoPlayerFuture = null;
    }
    var res =
        await DefaultAssetBundle.of(context).loadString("json/videoinfo.json");
    var resInfo = json.decode(res);

    setState(() {
      videoList = List<Video>.from(resInfo.map((x) => Video.fromJson(x)));
      // print(videoList);
    });
  }

  void _videoListener() {
    print("_videoListener");
    var curPosition = _controller?.value.position;
    var totalPosition = _controller?.value.duration;
    setState(() {
      _curPos = curPosition.toString().substring(2, 7);
      _totalPos = totalPosition.toString().substring(2, 7);
      _videoTime = "${_curPos}/${_totalPos}";
    });
    print("current position: ${_curPos}，end point: ${_totalPos}");
    if (curPosition.toString() != "0:00:00.000000" &&
        curPosition == totalPosition) {
      setState(() {
        _isPlayingIndex = _isPlayingIndex + 1;
        if (_isPlayingIndex >= videoList.length) {
          _isPlayingIndex = 0;
        }
      });
      _playVideo(videoList.elementAt(_isPlayingIndex).videoUrl!);
    }
  }

  _playVideo(String url) {
    setState(() {
      _controller?.removeListener(_videoListener);
      _controller?.dispose();
      _controller = null;
      _initializeVideoPlayerFuture = null;
      _curPos = "";
      _totalPos = "";
      _videoTime = "";
      _controller = VideoPlayerController.network(url);

      /*
      _initializeVideoPlayerFuture = _controller?.initialize().then((_) {
        _controller?.seekTo(Duration(milliseconds: 0));
        _controller?.play();
        _controller?.addListener(_videoListener);
      });*/
      _initializeVideoPlayerFuture = _controller?.initialize();

      chewieController = ChewieController(
          videoPlayerController: _controller!, autoPlay: true, looping: false);

      _initializeVideoPlayerFuture = _controller?.initialize();
    });
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    _controller = null;
    _initializeVideoPlayerFuture = null;
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: color.AppColor.darkGrey,
            body: CustomScrollView(slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.h,
                    horizontal: 0.w,
                  ),
                  sliver: SliverToBoxAdapter(
                      child: Container(
                    margin: EdgeInsets.only(top: 0.h, bottom: 25.h),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        color.AppColor.lightGrey.withOpacity(0.9),
                        color.AppColor.darkGrey
                      ],
                      begin: const FractionalOffset(0.0, 0.4),
                      end: Alignment.topRight,
                    )),
                    child: Column(
                      children: [
                        _playArea == false
                            ? Container(
                                padding: EdgeInsets.only(
                                    top: 30.h, left: 30.w, right: 30.w),
                                height: 300.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Icon(Icons.arrow_back_ios,
                                              size: 20,
                                              color: color.AppColor.orange),
                                        ),
                                        Expanded(child: Container()),
                                        Icon(Icons.info_outline,
                                            size: 20,
                                            color: color.AppColor.orange),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Text(
                                      "Legs Toning",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: color.AppColor.white),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "and Glutes Workout",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: color.AppColor.white),
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 90.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  color.AppColor.darkGrey,
                                                  color.AppColor.black
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                size: 20,
                                                color: color.AppColor.orange,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "68 min",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color:
                                                        color.AppColor.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 200.w,
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    color.AppColor.lightGrey,
                                                    color.AppColor.darkGrey,
                                                  ],
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.topRight,
                                                )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.handyman_outlined,
                                                  size: 20,
                                                  color: color.AppColor.white,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Container(
                                                  width: 100.w,
                                                  child: Text(
                                                    "Resistent band, kettebell",
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: color
                                                            .AppColor.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))
                            : Container(
                                padding:
                                    EdgeInsets.only(top: 30.h, bottom: 30.h),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 30.w, right: 30.w),
                                        margin: EdgeInsets.only(bottom: 30.h),
                                        child: Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Icon(
                                                    Icons.arrow_back_ios,
                                                    size: 20,
                                                    color:
                                                        color.AppColor.white)),
                                            Expanded(child: Container()),
                                            Icon(Icons.info_outline,
                                                size: 20,
                                                color: color.AppColor.white)
                                          ],
                                        )),
                                    Container(
                                      width: 325.w,
                                      height: 200.h,
                                      child: FutureBuilder(
                                        future: _initializeVideoPlayerFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return _controller == null
                                                ? Container()
                                                : AspectRatio(
                                                    aspectRatio: _controller!
                                                        .value.aspectRatio,
                                                    child: Stack(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      children: <Widget>[
                                                        VideoPlayer(
                                                            _controller!),
                                                        VideoProgressIndicator(
                                                          _controller!,
                                                          allowScrubbing: true,
                                                          colors:
                                                              VideoProgressColors(
                                                                  playedColor:
                                                                      Colors
                                                                          .red),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                          } else {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    _controlView(context),
                                  ],
                                )),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(70))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    "Circuit 1: Legs Toning",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: color.AppColor.orange),
                                  ),
                                  Expanded(child: Container()),
                                  Row(
                                    children: [
                                      Icon(Icons.loop,
                                          size: 30,
                                          color: color.AppColor.orange),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "3 sets",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: color.AppColor.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 0.h,
                  horizontal: 25.w,
                ),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (content, index) {
                    var item = videoList.elementAt(index);
                    print(item);
                    return _buildCard(content, index, item);
                  },
                  childCount: videoList.length,
                )),
              ),
            ])));
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        height: 40.h,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 5.h, top: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(50, 0, 0, 0),
                    )
                  ]),
                  child: Icon(
                    noMute ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                if (noMute) {
                  _controller?.setVolume(0);
                } else {
                  _controller?.setVolume(1.0);
                }
                setState(() {});
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isPlayingIndex = _isPlayingIndex - 1;
                  });
                  if (_isPlayingIndex < 0) {
                    setState(() {
                      _isPlayingIndex = 0;
                    });
                    Get.snackbar(
                      "Video List",
                      "",
                      snackPosition: SnackPosition.BOTTOM,
                      icon: Icon(
                        Icons.face,
                        size: 30,
                        color: Colors.white,
                      ),
                      backgroundColor: color.AppColor.black,
                      colorText: Colors.white,
                      messageText: Text(
                        "No videos ahead !",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    );
                    return;
                  }
                  var video_item = videoList.elementAt(_isPlayingIndex);
                  _playVideo(video_item.videoUrl!);
                },
                child: Icon(
                  Icons.fast_rewind,
                  size: 36,
                  color: Colors.white,
                )),
            ElevatedButton(
                onPressed: () async {
                  if (_isPlaying) {
                    setState(() {
                      _isPlaying = false;
                    });
                    _controller?.pause();
                  } else {
                    setState(() {
                      _isPlaying = true;
                    });
                    _controller?.play();
                  }
                },
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 36,
                  color: Colors.white,
                )),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isPlayingIndex = _isPlayingIndex + 1;
                  });
                  if (_isPlayingIndex >= videoList.length) {
                    setState(() {
                      _isPlayingIndex = _isPlayingIndex - 1;
                    });
                    Get.snackbar("Video List", "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: color.AppColor.black,
                        colorText: Colors.white,
                        messageText: Text(
                          "You have finished watching all the videos. Congrats !",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ));
                    return;
                  }
                  var video_item = videoList.elementAt(_isPlayingIndex);
                  _playVideo(video_item.videoUrl!);
                },
                child: Icon(
                  Icons.fast_forward,
                  size: 36,
                  color: Colors.white,
                )),
            Container(
              width: 100.w,
              margin: EdgeInsets.only(left: 10.w),
              child: Text(
                "${_videoTime}",
                style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(150, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  _buildCard(BuildContext context, int index, Video item) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (_playArea == false) {
              _playArea = true;
            }
            _isPlayingIndex = index;
          });
          if (item.videoUrl != null) {
            _playVideo(item.videoUrl!);
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                                videoList.elementAt(index).thumbnail ?? ""),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 160.w,
                          child: Text(
                            "${videoList.elementAt(index).title}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Text(
                          "${videoList.elementAt(index).time}",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 18.h,
              ),
              Row(
                children: [
                  Container(
                    width: 80.h,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFeaeefc),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "15s rest",
                        style: TextStyle(color: Color(0xFF839fed)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < 70; i++)
                        i.isEven
                            ? Container(
                                width: 3,
                                height: 1,
                                decoration: BoxDecoration(
                                    color: Color(0xFF839fed),
                                    borderRadius: BorderRadius.circular(2)),
                              )
                            : Container(
                                width: 3, height: 1, color: Colors.white)
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class Video {
  String? title;
  String? time;
  String? thumbnail;
  String? videoUrl;

  Video({
    this.title,
    this.time,
    this.thumbnail,
    this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json["title"],
        time: json["time"],
        thumbnail: json["thumbnail"],
        videoUrl: json["videoUrl"],
      );
}
