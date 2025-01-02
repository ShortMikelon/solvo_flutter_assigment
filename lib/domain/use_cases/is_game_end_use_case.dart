import 'package:solvo_flutter_assignment/data/in_memory_settings_repository.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';

import 'package:solvo_flutter_assignment/domain/entities/round.dart';

class IsGameEndUseCase {
  final RoundRepository _roundRepository;
  final InMemorySettingsRepository _settingsRepository;

  IsGameEndUseCase(
    InMemorySettingsRepository settingsRepository,
    RoundRepository roundRepository,
  )   : _settingsRepository = settingsRepository,
        _roundRepository = roundRepository;

  bool execute() {
    Round round = _roundRepository.currentRound;

    round.usedAttempts++;

    bool isGameEnd = round.usedAttempts == _settingsRepository.numberAttempts;
    if (isGameEnd) round.status = RoundStatus.lose;

    _roundRepository.updateRound(round);
    return isGameEnd;
  }
}
