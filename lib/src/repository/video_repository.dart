import 'package:video_player/src/model/video.dart';
import 'package:video_player/src/repository/network/video_service.dart';

class VideoRepository {
  final VideoService _service;
  VideoRepository(this._service);

  Future<List<Video>> getVideoListByText(String text, int limit) =>
      _service.getVideoListByText(text, limit);
}
