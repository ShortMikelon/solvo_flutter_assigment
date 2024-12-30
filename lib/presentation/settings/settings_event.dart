part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class OnChangeMaxValueEvent extends SettingsEvent {
  final int maxValue;

  const OnChangeMaxValueEvent(this.maxValue);

  @override
  List<Object?> get props => [maxValue];
}

class OnChangeNumberAttemptsEvent extends SettingsEvent {
  final int numberAttempts;

  const OnChangeNumberAttemptsEvent(this.numberAttempts);

  @override
  List<Object?> get props => [numberAttempts];
}

class OnPressedLaunchButtonEvent extends SettingsEvent {
  const OnPressedLaunchButtonEvent();

  @override
  List<Object?> get props => [];
}

