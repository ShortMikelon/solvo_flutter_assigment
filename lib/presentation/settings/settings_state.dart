part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();
}

final class SettingsInitial extends SettingsState {
  final int maxValue;
  final int numberAttempts;

  const SettingsInitial(this.maxValue, this.numberAttempts);

  @override
  List<Object> get props => [maxValue, numberAttempts];
}

final class LaunchGameState extends SettingsState {
  const LaunchGameState();

  @override
  List<Object?> get props => [];
}