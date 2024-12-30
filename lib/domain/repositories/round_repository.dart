import 'package:solvo_flutter_assignment/domain/entities/round.dart';

abstract class RoundRepository {
  bool get isLastRoundOver;

  Round get currentRound;

  List<Round> get allRounds;

  void loadLastRound();

  void updateRound(Round round);

  Round createNewRound(int correctAnswer);
}

class InvalidCurrentCorrectAnswerException implements Exception {}