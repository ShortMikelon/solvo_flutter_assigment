part of 'guess_number_bloc.dart';

sealed class GuessNumberEvent {
  const GuessNumberEvent();
}

class OnNumberEnterEvent extends GuessNumberEvent {}

class OnRestartEvent extends GuessNumberEvent {}

class OnTextChangedEvent extends GuessNumberEvent {
  final String text;

  const OnTextChangedEvent(this.text) : super();
}

class OnLoadPageEvent extends GuessNumberEvent {}