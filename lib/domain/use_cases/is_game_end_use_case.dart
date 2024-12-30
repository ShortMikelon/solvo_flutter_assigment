import 'package:solvo_flutter_assignment/data/answers_repository.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';

import 'package:solvo_flutter_assignment/domain/entities/round.dart';

class IsGameEndUseCase {
  final RoundRepository _roundRepository;
  final AnswerRepository _answerRepository;

  IsGameEndUseCase(
    AnswerRepository answerRepository,
    RoundRepository roundRepository,
  )   : _answerRepository = answerRepository,
        _roundRepository = roundRepository;

  bool execute() {
    Round round = _roundRepository.currentRound;

    round.usedAttempts++;

    bool isGameEnd = round.usedAttempts == _answerRepository.numberAttempts;
    if (isGameEnd) round.status = RoundStatus.lose;

    _roundRepository.updateRound(round);
    return isGameEnd;
  }
}
