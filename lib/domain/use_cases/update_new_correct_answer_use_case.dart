import 'dart:math';

import 'package:solvo_flutter_assignment/data/answers_repository.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';

class UpdateNewCorrectAnswerUseCase {
  final AnswerRepository _answerRepository;
  final RoundRepository _roundRepository;

  const UpdateNewCorrectAnswerUseCase(
    AnswerRepository answerRepository,
    RoundRepository roundRepository,
  )   : _answerRepository = answerRepository,
        _roundRepository = roundRepository;

  void execute() {
    int newCorrectAnswer = Random().nextInt(_answerRepository.maxValue);

    _roundRepository.createNewRound(newCorrectAnswer);
  }
}
