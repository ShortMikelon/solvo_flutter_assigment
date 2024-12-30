import 'package:flutter_bloc/flutter_bloc.dart';

sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class LaunchGameState extends HomeState {}

final class ContinueGameState extends HomeState {}

sealed class HomeEvent {}

final class LoadDataEvent extends HomeEvent {}

final class OnPressedStartButtonEvent extends HomeEvent {}

final class OnPressedContinueButtonEvent extends HomeEvent {}

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc()   : super(HomeInitialState()) {
    on<LoadDataEvent>(_handleLoadDataEvent);
    on<OnPressedStartButtonEvent>(_handleOnPressedStartButtonEvent);
    on<OnPressedContinueButtonEvent>(_handleOnPressedContinueButtonEvent);
  }

  void _handleLoadDataEvent(
    LoadDataEvent event,
    Emitter<HomeState> emitter,
  ) {
    HomeState state = HomeInitialState();
    emitter(state);
  }

  void _handleOnPressedStartButtonEvent(
    OnPressedStartButtonEvent event,
    Emitter<HomeState> emitter,
  ) {
    emitter(LaunchGameState());
  }

  void _handleOnPressedContinueButtonEvent(
    OnPressedContinueButtonEvent event,
    Emitter<HomeState> emitter,
  ) {
    emitter(ContinueGameState());
  }
}
