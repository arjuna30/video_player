import 'package:video_player_app/src/model/video.dart';
import 'package:video_player_app/src/repository/network/video_service.dart';

class VideoRepository {
  final VideoService _service;
  VideoRepository(this._service);

  Future<List<Video>> getVideoListByText(String text, int limit) async =>
      _service.getVideoListByText(text, limit);
}
