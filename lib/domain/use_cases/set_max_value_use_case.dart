import 'package:solvo_flutter_assignment/data/in_memory_settings_repository.dart';

class SaveSettingsUseCase {
  final InMemorySettingsRepository _settingsRepository;

  const SaveSettingsUseCase(this._settingsRepository);

  void execute(int newMaxValue, int numberAttempts) {
    _settingsRepository.maxValue = newMaxValue;
    _settingsRepository.numberAttempts = numberAttempts;
  }
}