import 'package:solvo_flutter_assignment/domain/entities/round.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';

class CheckAnswerUseCase {
  final RoundRepository _roundRepository;

  int currentAttempt = 0;

  CheckAnswerUseCase(RoundRepository roundRepository) : _roundRepository = roundRepository;

  bool execute(String answer) {
    bool isCorrectAnswer =_roundRepository.currentRound.correctAnswer == int.parse(answer);
    if (isCorrectAnswer) {
      _roundRepository.currentRound.status = RoundStatus.win;
    }

    _roundRepository.updateRound(_roundRepository.currentRound);

    return isCorrectAnswer;
  }
}