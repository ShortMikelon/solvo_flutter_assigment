import 'dart:math';

import 'package:solvo_flutter_assignment/data/in_memory_settings_repository.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';

class UpdateNewCorrectAnswerUseCase {
  final InMemorySettingsRepository _settingsRepository;
  final RoundRepository _roundRepository;

  const UpdateNewCorrectAnswerUseCase(
    InMemorySettingsRepository settingsRepository,
    RoundRepository roundRepository,
  )   : _settingsRepository = settingsRepository,
        _roundRepository = roundRepository;

  void execute() {
    int newCorrectAnswer = Random().nextInt(_settingsRepository.maxValue);

    _roundRepository.createNewRound(newCorrectAnswer);
  }
}
