import 'package:solvo_flutter_assignment/domain/entities/round.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';

class InMemoryRoundRepository extends RoundRepository {
  static int _lastId = 0;

  final List<Round> _allRounds = [];

  Round? _currentRound;

  @override
  List<Round> get allRounds => _allRounds;

  @override
  Round get currentRound {
    if (_currentRound != null) {
      return _currentRound!;
    } else {
      throw RoundNotFoundException();
    }
  }

  @override
  bool get isLastRoundOver => _allRounds.isEmpty || _allRounds.last.status != RoundStatus.notFinished;

  @override
  Round createNewRound(int correctAnswer) {
    if (correctAnswer < 0) throw InvalidCorrectAnswerException();
    
    _lastId++;

    Round round = Round(
      id: _lastId,
      correctAnswer: correctAnswer,
      usedAttempts: 0,
      status: RoundStatus.notFinished,
      datetime: DateTime.timestamp(),
    );

    _allRounds.add(round);
    _currentRound = round;

    return round;
  }

  @override
  void loadLastRound() {
    if (_allRounds.isEmpty) throw LoadLastRoundException();
    _currentRound = _allRounds.last;
  }

  @override
  void updateRound(Round round) {
    int roundIndex = _allRounds.indexWhere((item) => item.id == round.id);
    if (roundIndex == -1) throw RoundNotFoundException();

    _allRounds[roundIndex] = round;

    _currentRound = round;
  }
}