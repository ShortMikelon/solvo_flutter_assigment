import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solvo_flutter_assignment/domain/entities/round.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/check_answer_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/get_attempts_count_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/get_current_round_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/is_game_end_use_case.dart';

part 'guess_number_event.dart';

part 'guess_number_state.dart';

class GuessNumberBloc extends Bloc<GuessNumberEvent, GuessNumberState> {
  final CheckAnswerUseCase _checkAnswerUseCase;
  final IsGameEndUseCase _isGameEndUseCase;
  final GetCurrentRoundUseCase _getCurrentRoundUseCase;
  final GetAttemptsCountUseCase _getAttemptsCountUseCase;

  String _currentAnswer = '';

  GuessNumberBloc(
    CheckAnswerUseCase checkAnswerUseCase,
    IsGameEndUseCase isGameEndUseCase,
    GetCurrentRoundUseCase getCurrentRoundUseCase,
    GetAttemptsCountUseCase getAttemptsCountUseCase,
  )   : _checkAnswerUseCase = checkAnswerUseCase,
        _isGameEndUseCase = isGameEndUseCase,
        _getCurrentRoundUseCase = getCurrentRoundUseCase,
        _getAttemptsCountUseCase = getAttemptsCountUseCase,
        super(InitialState('', 0)) {
    on<OnNumberEnterEvent>(_handleOnNumberEnterEvent);
    on<OnRestartEvent>(_handleOnRestartEvent);
    on<OnTextChangedEvent>(_handleOnTextChangedEvent);
    on<OnLoadPageEvent>(_handleOnLoadPageEvent);

    add(OnLoadPageEvent());
  }

  void _handleOnNumberEnterEvent(
    OnNumberEnterEvent event,
    Emitter<GuessNumberState> emitter,
  ) {
    if (_currentAnswer.isEmpty) {
      emitter(
        IncorrectAnswerState(
          _currentAnswer,
          _getAttemptsCountUseCase.execute(),
          true,
        ),
      );
    }

    GuessNumberState newState;

    bool isCorrect = _checkAnswerUseCase.execute(_currentAnswer);
    bool isGameEnd = _isGameEndUseCase.execute();

    if (isCorrect || isGameEnd) {
      Round round = _getCurrentRoundUseCase.execute();
      newState = GameEndState(round);
    } else {
      int attemptsCount = _getAttemptsCountUseCase.execute();
      newState = IncorrectAnswerState(_currentAnswer, attemptsCount);
    }

    emitter(newState);
  }

  void _handleOnRestartEvent(
    OnRestartEvent event,
    Emitter<GuessNumberState> emitter,
  ) {
    emitter(RestartedState());
  }

  void _handleOnTextChangedEvent(
    OnTextChangedEvent event,
    Emitter<GuessNumberState> emitter,
  ) {
    _currentAnswer = event.text;

    GuessNumberState newState =
        InitialState(_currentAnswer, _getAttemptsCountUseCase.execute());

    emitter(newState);
  }

  void _handleOnLoadPageEvent(
    OnLoadPageEvent event,
    Emitter<GuessNumberState> emitter,
  ) {
    emitter(
      InitialState(
        _currentAnswer,
        _getAttemptsCountUseCase.execute(),
      ),
    );
  }
}
