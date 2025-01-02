import 'package:injector/injector.dart';
import 'package:solvo_flutter_assignment/data/in_memory_settings_repository.dart';
import 'package:solvo_flutter_assignment/data/in_memory_round_repository.dart';
import 'package:solvo_flutter_assignment/domain/repositories/round_repository.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/check_answer_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/get_attempts_count_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/get_current_round_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/is_game_end_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/set_max_value_use_case.dart';
import 'package:solvo_flutter_assignment/domain/use_cases/update_new_correct_answer_use_case.dart';
import 'package:solvo_flutter_assignment/presentation/guess_number/guess_number_bloc.dart';
import 'package:solvo_flutter_assignment/presentation/home/home_bloc.dart';
import 'package:solvo_flutter_assignment/presentation/settings/settings_bloc.dart';

class DependencyInjector {
  static final Injector _injector = Injector.appInstance;

  static void configure() {
    _configureRepositories();
    _configureUseCases();
    _configureBlocs();
  }

  static void _configureBlocs() {
    _injector.registerDependency<GuessNumberBloc>(
      () => GuessNumberBloc(
        _injector.get<CheckAnswerUseCase>(),
        _injector.get<IsGameEndUseCase>(),
        _injector.get<GetCurrentRoundUseCase>(),
        _injector.get<GetAttemptsCountUseCase>(),
      ),
    );

    _injector.registerDependency<HomeBloc>(
      () => HomeBloc(),
    );

    _injector.registerDependency<SettingsBloc>(
      () => SettingsBloc(
        _injector.get<SaveSettingsUseCase>(),
        _injector.get<UpdateNewCorrectAnswerUseCase>(),
      ),
    );
  }

  static void _configureRepositories() {
    _injector.registerSingleton<InMemorySettingsRepository>(() => InMemorySettingsRepository());

    _injector
        .registerSingleton<RoundRepository>(() => InMemoryRoundRepository());
  }

  static void _configureUseCases() {
    _injector.registerSingleton<SaveSettingsUseCase>(() {
      final settingsRepository = _injector.get<InMemorySettingsRepository>();

      return SaveSettingsUseCase(settingsRepository);
    });

    _injector.registerSingleton<UpdateNewCorrectAnswerUseCase>(() {
      final settingsRepository = _injector.get<InMemorySettingsRepository>();
      final roundRepository = _injector.get<RoundRepository>();

      return UpdateNewCorrectAnswerUseCase(settingsRepository, roundRepository);
    });

    _injector.registerSingleton<CheckAnswerUseCase>(() {
      final roundRepository = _injector.get<RoundRepository>();

      return CheckAnswerUseCase(roundRepository);
    });

    _injector.registerSingleton<IsGameEndUseCase>(() {
      final settingsRepository = _injector.get<InMemorySettingsRepository>();
      final roundRepository = _injector.get<RoundRepository>();

      return IsGameEndUseCase(settingsRepository, roundRepository);
    });

    _injector.registerSingleton<GetCurrentRoundUseCase>(() {
      final roundRepository = _injector.get<RoundRepository>();

      return GetCurrentRoundUseCase(roundRepository);
    });

    _injector.registerSingleton<GetAttemptsCountUseCase>(() {
      final settingsRepository = _injector.get<InMemorySettingsRepository>();
      final roundRepository = _injector.get<RoundRepository>();

      return GetAttemptsCountUseCase(settingsRepository, roundRepository);
    });
  }
}
