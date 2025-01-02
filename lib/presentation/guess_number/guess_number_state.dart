part of 'guess_number_bloc.dart';

sealed class GuessNumberState {}

class InitialState extends GuessNumberState {
  final String answer;
  final int attemptsCount;

  InitialState(this.answer, this.attemptsCount);
}

class IncorrectAnswerState extends GuessNumberState {
  final String answer;
  final int attemptsCount;
  final bool isEmptyField;

  IncorrectAnswerState(this.answer, this.attemptsCount, [this.isEmptyField = false]);
}

class RestartedState extends GuessNumberState {}

class GameEndState extends GuessNumberState {
  final Round round;
  GameEndState(this.round);
}
