import 'package:solvo_flutter_assignment/domain/entities/round.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';

class GetCurrentRoundUseCase {
  final RoundRepository _roundRepository;

  const GetCurrentRoundUseCase(RoundRepository roundRepository)
      : _roundRepository = roundRepository;

  Round execute() {
    return _roundRepository.currentRound;
  }
}
