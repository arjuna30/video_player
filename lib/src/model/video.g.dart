// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Video _$$_VideoFromJson(Map<String, dynamic> json) => _$_Video(
      wrapperType: json['wrapperType'] as String,
      collectionId: json['collectionId'] as int,
      collectionArtistId: json['collectionArtistId'] as int,
      trackId: json['trackId'] as int,
      kind: json['kind'] as String,
      trackName: json['trackName'] as String,
      artistName: json['artistName'] as String,
      collectionName: json['collectionName'] as String,
      previewUrl: json['previewUrl'] as String,
      artworkUrl30: json['artworkUrl30'] as String,
      artworkUrl60: json['artworkUrl60'] as String,
      artworkUrl100: json['artworkUrl100'] as String,
      releaseDate: DateTime.parse(json['releaseDate'] as String),
    );

Map<String, dynamic> _$$_VideoToJson(_$_Video instance) => <String, dynamic>{
      'wrapperType': instance.wrapperType,
      'collectionId': instance.collectionId,
      'collectionArtistId': instance.collectionArtistId,
      'trackId': instance.trackId,
      'kind': instance.kind,
      'trackName': instance.trackName,
      'artistName': instance.artistName,
      'collectionName': instance.collectionName,
      'previewUrl': instance.previewUrl,
      'artworkUrl30': instance.artworkUrl30,
      'artworkUrl60': instance.artworkUrl60,
      'artworkUrl100': instance.artworkUrl100,
      'releaseDate': instance.releaseDate.toIso8601String(),
    };
