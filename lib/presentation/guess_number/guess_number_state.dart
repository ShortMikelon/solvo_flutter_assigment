part of 'guess_number_bloc.dart';

sealed class GuessNumberState {
  final String answer;

  GuessNumberState(this.answer);
}

class InitialState extends GuessNumberState {
  InitialState(super.answer);
}

class IncorrectAnswerState extends GuessNumberState {
  IncorrectAnswerState(super.answer);
}

class RestartedState extends GuessNumberState {
  RestartedState(super.answer);
}

class GameEndState extends GuessNumberState {
  final Round round;
  GameEndState(super.answer, this.round);
}
