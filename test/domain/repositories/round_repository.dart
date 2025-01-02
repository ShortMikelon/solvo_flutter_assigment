import 'package:flutter_test/flutter_test.dart';
import 'package:solvo_flutter_assignment/data/in_memory_round_repository.dart';
import 'package:solvo_flutter_assignment/domain/entities/round.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';

void main() {
  group('Round repository test', () {
    test('isLastRoundOver_whenLastRoundWin_returnsTrue', () {
      RoundRepository roundRepository = InMemoryRoundRepository();
      Round round = roundRepository.createNewRound(0);
      round.status = RoundStatus.win;
      roundRepository.updateRound(round);

      final actual = roundRepository.isLastRoundOver;

      expect(actual, true);
    });

    test('isLastRoundOver_whenLastRoundLose_returnsTrue', () {
      RoundRepository roundRepository = InMemoryRoundRepository();
      Round round = roundRepository.createNewRound(0);
      round.status = RoundStatus.lose;
      roundRepository.updateRound(round);

      final actual = roundRepository.isLastRoundOver;

      expect(actual, true);
    });

    test('isLastRoundOver_whenLastRoundNotFinished_returnsFalse', () {
      RoundRepository roundRepository = InMemoryRoundRepository();
      Round round = roundRepository.createNewRound(0);
      round.status = RoundStatus.notFinished;
      roundRepository.updateRound(round);

      final actual = roundRepository.isLastRoundOver;

      expect(actual, false);
    });

    test('currentRound_whenCurrentRoundAvailable_returnsRound', () {
      RoundRepository roundRepository = InMemoryRoundRepository();
      final expected = roundRepository.createNewRound(0);

      final actual = roundRepository.currentRound;

      expect(actual, expected);
    });

    test(
      'currentRound_whenCurrentRoundNotAvailable_throwsRoundNotFoundException',
      () {
        RoundRepository roundRepository = InMemoryRoundRepository();

        try {
          roundRepository.currentRound;

          fail('currentRound not throws exception');
        } on RoundNotFoundException catch (e) {
          expect(e, isA<RoundNotFoundException>());
        }
      },
    );

    test('allRounds_whenListIsEmpty_returnsEmptyList', () {
      RoundRepository roundRepository = InMemoryRoundRepository();

      final rounds = roundRepository.allRounds;

      expect(rounds.isEmpty, true);
    });

    test('allRounds_whenListIsNotEmpty_returnsList', () {
      RoundRepository roundRepository = InMemoryRoundRepository();
      final expected = <Round>[
        roundRepository.createNewRound(0),
        roundRepository.createNewRound(1),
        roundRepository.createNewRound(2),
      ];

      final actual = roundRepository.allRounds;

      expect(actual.isNotEmpty, true);
      expect(actual, expected);
    });

    test(
      'loadLastRound_whenRoundIsAvailable_thenLoadLastRoundInCurrentRound',
      () {
        RoundRepository roundRepository = InMemoryRoundRepository();
        final expected = roundRepository.createNewRound(0);

        roundRepository.loadLastRound();
        final actual = roundRepository.currentRound;

        expect(actual, expected);
      },
    );

    test('updateRound_whenRoundIsAvailable_successfulUpdated', () {
      RoundRepository roundRepository = InMemoryRoundRepository();
      final round = roundRepository.createNewRound(0);

      round.usedAttempts = 1;
      roundRepository.updateRound(round);
      final expected = roundRepository.currentRound;

      expect(expected.id, round.id);
      expect(expected.correctAnswer, round.correctAnswer);
      expect(expected.datetime, round.datetime);
      expect(expected.usedAttempts, round.usedAttempts);
      expect(expected.status, round.status);
    });

    test(
      'updateRound_whenRoundIsNotAvailable_throwsRoundNotFoundException',
      () {
        RoundRepository roundRepository = InMemoryRoundRepository();
        roundRepository.createNewRound(0);
        final testRound = Round(
          id: -1,
          correctAnswer: 0,
          usedAttempts: 0,
          status: RoundStatus.win,
          datetime: DateTime.timestamp(),
        );

        actual() {
          roundRepository.updateRound(testRound);
        }

        expect(actual, throwsA(isA<RoundNotFoundException>()));
      },
    );

    test('createNewRound_whenCorrectAnswer_returnsNewRound', () {
      RoundRepository roundRepository = InMemoryRoundRepository();
      const testCorrectAnswer = 1;

      final actual = roundRepository.createNewRound(testCorrectAnswer);

      expect(actual.correctAnswer, testCorrectAnswer);
    });

    test(
      'createNewRound_whenAnswerIsIncorrect_throwsInvalidCorrectAnswerException',
      () {
        RoundRepository roundRepository = InMemoryRoundRepository();
        const testCorrectAnswer = -1;

        actual() {
          roundRepository.createNewRound(testCorrectAnswer);
        }

        expect(actual, throwsA(isA<InvalidCorrectAnswerException>()));
      },
    );
  });
}
