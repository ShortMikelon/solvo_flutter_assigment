class AnswerRepository {
  int _maxValue = 10;

  int _numberAttempts = 5;

  int get maxValue => _maxValue;

  set maxValue(int newValue) {
    if (newValue <= 0) throw InvalidMaxValueException();
    _maxValue = newValue;
  }

  int get numberAttempts => _numberAttempts;

  set numberAttempts(int newValue) {
    if (newValue < 0) throw InvalidNumberAttemptsException();
    _numberAttempts = numberAttempts;
  }
}

class InvalidMaxValueException implements Exception {}

class InvalidNumberAttemptsException implements Exception {}