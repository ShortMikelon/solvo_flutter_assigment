final class Round {
  final int id;
  final int correctAnswer;
  int usedAttempts;
  RoundStatus status;
  final DateTime datetime;

  Round({
    required this.id,
    required this.correctAnswer,
    required this.usedAttempts,
    required this.status,
    required this.datetime,
  });
}

enum RoundStatus {
  win,
  lose,
  notFinished,
}
