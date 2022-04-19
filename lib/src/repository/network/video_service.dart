import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:video_player_app/src/model/video.dart';

class VideoService {
  final Dio _dio;
  VideoService(this._dio);

  Future<List<Video>> getVideoListByText(String text, int limit) async {
    final videoList = <Video>[];
    final _encodedUrl =
        Uri.encodeFull('term=$text&limit=$limit&entity=movie,musicVideo');
    final response = await _dio.get(_encodedUrl);
    final decoded = json.decode(response.data);
    final videos = decoded['results'] as List;
    for (final video in videos) {
      videoList.add(Video.fromJson(video));
    }
    return videoList;
  }
}
