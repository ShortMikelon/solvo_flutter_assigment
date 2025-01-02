abstract class SettingsRepository {
  int get numberAttempts;

  set numberAttempts(int newValue);

  int get maxValue;

  set maxValue(int newValue);
}

class InvalidMaxValueException implements Exception {}

class InvalidNumberAttemptsException implements Exception {}