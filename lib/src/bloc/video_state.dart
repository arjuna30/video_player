part of 'video_cubit.dart';

@immutable
abstract class VideoState {}

class VideoInitial extends VideoState {}

class LoadingVideoState extends VideoState {}

class SuccessFetchVideoState extends VideoState {
  final VideoPlayerController playerController;
  final String url;

  SuccessFetchVideoState(this.playerController, this.url);
}

class ErrorFetchVideoState extends VideoState {
  final dynamic e;

  ErrorFetchVideoState(this.e);
}
