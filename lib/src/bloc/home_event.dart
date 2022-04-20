part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SearchVideoEvent extends HomeEvent {
  final String text;
  final int limit;

  SearchVideoEvent(this.text, this.limit);
}
