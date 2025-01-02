import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/set_max_value_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/update_new_correct_answer_use_case.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const int initialMaxValue = 5;
  static const int initialNumberAttempts = 5;

  final SaveSettingsUseCase _saveSettingsUseCase;
  final UpdateNewCorrectAnswerUseCase _startNewRoundUseCase;

  int _currentMaxValue = initialMaxValue;
  int _currentNumberAttempts = initialNumberAttempts;

  SettingsBloc(
    SaveSettingsUseCase saveSettingsUseCase,
    UpdateNewCorrectAnswerUseCase startNewRoundUseCase,
  )   : _saveSettingsUseCase = saveSettingsUseCase,
        _startNewRoundUseCase = startNewRoundUseCase,
        super(
          const SettingsInitial(initialMaxValue, initialNumberAttempts),
        ) {
    on<OnChangeMaxValueEvent>(_handleOnChangeMaxValueEvent);
    on<OnChangeNumberAttemptsEvent>(_handleOnChangeNumberAttemptsEvent);
    on<OnPressedLaunchButtonEvent>(_handleOnPressedLaunchButtonEvent);
  }

  void _handleOnChangeMaxValueEvent(
    OnChangeMaxValueEvent event,
    Emitter<SettingsState> emitter,
  ) {
    _currentMaxValue = event.maxValue;

    emitter(SettingsInitial(_currentMaxValue, _currentNumberAttempts));
  }

  void _handleOnChangeNumberAttemptsEvent(
    OnChangeNumberAttemptsEvent event,
    Emitter<SettingsState> emitter,
  ) {
    _currentNumberAttempts = event.numberAttempts;

    emitter(SettingsInitial(_currentMaxValue, _currentNumberAttempts));
  }

  void _handleOnPressedLaunchButtonEvent(
    OnPressedLaunchButtonEvent event,
    Emitter<SettingsState> emitter,
  ) {
    _saveSettingsUseCase.execute(_currentMaxValue, _currentNumberAttempts);
    log('settings: maxvalue: $_currentMaxValue and number attempts: $_currentNumberAttempts');
    _startNewRoundUseCase.execute();

    emitter(LaunchGameState(_currentMaxValue, _currentNumberAttempts));
  }
}
