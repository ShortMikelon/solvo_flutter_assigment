import 'package:solvo_flutter_assignment/data/answers_repository.dart';

class SaveSettingsUseCase {
  final AnswerRepository _answerRepository;

  const SaveSettingsUseCase(this._answerRepository);

  void execute(int newMaxValue, int numberAttempts) {
    _answerRepository.maxValue = newMaxValue;
    _answerRepository.numberAttempts = numberAttempts;
  }
}