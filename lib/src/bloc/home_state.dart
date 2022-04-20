part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingHomeState extends HomeState {}

class SuccessSearchHomeState extends HomeState {
  final List<Video> videos;

  SuccessSearchHomeState(this.videos);
}

class ErrorHomeState extends HomeState {
  final dynamic e;

  ErrorHomeState(this.e);
}
