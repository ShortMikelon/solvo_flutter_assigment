import 'package:solvo_flutter_assignment/data/in_memory_settings_repository.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';

class GetAttemptsCountUseCase {
  final InMemorySettingsRepository _settingsRepository;

  final RoundRepository _roundRepository;

  const GetAttemptsCountUseCase(
    InMemorySettingsRepository settingsRepository,
    RoundRepository roundRepository,
  )   : _settingsRepository = settingsRepository,
        _roundRepository = roundRepository;

  int execute() {
    return _settingsRepository.numberAttempts -
        _roundRepository.currentRound.usedAttempts;
  }
}
