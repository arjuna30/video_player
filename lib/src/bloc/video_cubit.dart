import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  static VideoCubit create(BuildContext context) => VideoCubit();
  VideoCubit() : super(VideoInitial());

  Future<void> fetchVideo(String videoUrl) async {
    late VideoPlayerController playerController;
    try {
      emit(LoadingVideoState());
      playerController = VideoPlayerController.network(videoUrl);
      playerController.pause();
      await playerController.initialize();
      if (playerController.value.isInitialized) {
        emit(SuccessFetchVideoState(playerController, videoUrl));
      }
    } catch (e) {
      emit(ErrorFetchVideoState(e));
    }
  }
}
