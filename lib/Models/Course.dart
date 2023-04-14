class Course {
  String title;
  String description;
  String time;
  String price;
  String thumbnail;
  List<Video> videoList;

  Course({
    required this.title,
    required this.description,
    required this.time,
    required this.price,
    required this.thumbnail,
    required this.videoList,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    List<Video>? videos = (json['VideoList'] as List<dynamic>?)
        ?.map((videoJson) => Video.fromJson(videoJson))
        .toList();
    return Course(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      price: json['price'] ?? '',
      time: json['time'] ?? '',
      videoList: videos ?? [],
    );
  }
}

class Video {
  String title;
  String description;
  String time;
  String thumbnail;
  String videoUrl;

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
