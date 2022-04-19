import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  const factory Video({
    required String wrapperType,
    int? collectionId,
    int? collectionArtistId,
    required int trackId,
    required String kind,
    required String trackName,
    required String artistName,
    String? collectionName,
    required String previewUrl,
    required String artworkUrl30,
    required String artworkUrl60,
    required String artworkUrl100,
    required DateTime releaseDate,
    required int trackTimeMillis,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
