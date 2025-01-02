import 'package:solvo_flutter_assignment/domain/repositories/settings_repository.dart';

class InMemorySettingsRepository implements SettingsRepository {
  int _maxValue = 10;

  int _numberAttempts = 5;

  @override
  int get maxValue => _maxValue;

  @override
  set maxValue(int newValue) {
    if (newValue <= 0) throw InvalidMaxValueException();
    _maxValue = newValue;
  }

  @override
  int get numberAttempts => _numberAttempts;

  @override
  set numberAttempts(int newValue) {
    if (newValue < 0) throw InvalidNumberAttemptsException();
    _numberAttempts = newValue;
  }
}