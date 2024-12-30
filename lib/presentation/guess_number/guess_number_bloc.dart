import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solvo_flutter_assignment/domain/entities/round.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/check_answer_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/get_current_round_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/is_game_end_use_case.dart';

part 'guess_number_event.dart';
part 'guess_number_state.dart';

class GuessNumberBloc extends Bloc<GuessNumberEvent, GuessNumberState> {
  final CheckAnswerUseCase _checkAnswerUseCase;
  final IsGameEndUseCase _isGameEndUseCase;
  final GetCurrentRoundUseCase _getCurrentRoundUseCase;

  GuessNumberState _state = InitialState('');

  GuessNumberBloc(
    CheckAnswerUseCase checkAnswerUseCase,
    IsGameEndUseCase isGameEndUseCase,
    GetCurrentRoundUseCase getCurrentRoundUseCase,
  )   : _checkAnswerUseCase = checkAnswerUseCase,
        _isGameEndUseCase = isGameEndUseCase,
        _getCurrentRoundUseCase = getCurrentRoundUseCase,
        super(InitialState('')) {
    on<OnNumberEnterEvent>(_handleOnNumberEnterEvent);
    on<OnRestartEvent>(_handleOnRestartEvent);
    on<OnTextChangedEvent>(_handleOnTextChangedEvent);
  }

  void _handleOnNumberEnterEvent(
    OnNumberEnterEvent event,
    Emitter<GuessNumberState> emitter,
  ) {
    bool isCorrect = _checkAnswerUseCase.execute(_state.answer);
    bool isGameEnd = _isGameEndUseCase.execute();

    if (isCorrect || isGameEnd) {
      Round round = _getCurrentRoundUseCase.execute();
      _state = GameEndState(_state.answer, round);
    } else {
      _state = IncorrectAnswerState(_state.answer);
    }

    emitter(_state);
  }

  void _handleOnRestartEvent(
    OnRestartEvent event,
    Emitter<GuessNumberState> emitter,
  ) {
    _state = RestartedState(_state.answer);
    emitter(_state);
  }

  void _handleOnTextChangedEvent(
    OnTextChangedEvent event,
    Emitter<GuessNumberState> emitter,
  ) {
    if (_state is InitialState) {
      _state = InitialState(event.text);
    } else if (_state is IncorrectAnswerState) {
      _state = IncorrectAnswerState(event.text);
    } else if (_state is RestartedState) {
      _state = RestartedState(event.text);
    }
  }
}
