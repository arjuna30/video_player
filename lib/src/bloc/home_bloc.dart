import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:video_player_app/src/model/video.dart';
import 'package:video_player_app/src/repository/video_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final VideoRepository _repository;
  static HomeBloc create(BuildContext context) => HomeBloc(Modular.get());

  HomeBloc(this._repository) : super(HomeInitial()) {
    on<SearchVideoEvent>(_search);
  }

  Future<void> _search(SearchVideoEvent event, Emitter emit) async {
    try {
      emit(LoadingHomeState());
      final response =
          await _repository.getVideoListByText(event.text, event.limit);
      emit(SuccessSearchHomeState(response));
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorHomeState(e));
    }
  }
}
