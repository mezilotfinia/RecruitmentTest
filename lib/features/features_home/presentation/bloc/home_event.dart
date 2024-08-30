part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LoadApiEvent extends HomeEvent {
  LoadApiEvent();
}
