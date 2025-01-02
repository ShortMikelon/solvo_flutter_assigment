import 'package:flutter_test/flutter_test.dart';
import 'package:solvo_flutter_assignment/data/in_memory_settings_repository.dart';
import 'package:solvo_flutter_assignment/domain/repositories/settings_repository.dart';

void main() {
  group('Settings Repository Test', () {
    late SettingsRepository settingsRepository;

    setUpAll(() {
      settingsRepository = InMemorySettingsRepository();
    });

    test('setNumberAttempts_whenNewValueIsCorrect_returnsValue', () {
      const expectNumberAttempts = 10;

      settingsRepository.numberAttempts = expectNumberAttempts;

      expect(settingsRepository.numberAttempts, expectNumberAttempts);
    });

    test(
      'setNumberAttempts_whenNewValueIsIncorrect_throwsInvalidNumberAttemptsException',
      () {
        actual() {
          settingsRepository.numberAttempts = -1;
        }

        expect(
          actual,
          throwsA(
            isA<InvalidNumberAttemptsException>(),
          ),
        );
      },
    );

    test('setMaxValue_whenNewValueIsCorrect_returnsValue', () {
      const expected = 10;

      settingsRepository.maxValue = expected;

      expect(settingsRepository.maxValue, expected);
    });

    test(
      'setMaxValue_whenNewValueIsIncorrect_throwsInvalidMaxValueException',
      () {
        actual() {
          settingsRepository.maxValue = -1;
        }

        expect(
          actual,
          throwsA(isA<InvalidMaxValueException>()),
        );
      },
    );
  });
}
