import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:solvo_flutter_assignment/presentation/guess_number/guess_number_page.dart';
import 'package:solvo_flutter_assignment/presentation/settings/settings_bloc.dart';
import 'package:solvo_flutter_assignment/widgets/app_buttons.dart';

class SettingsPage extends StatelessWidget {
  static const String route = 'settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: const _PageBody(),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector.appInstance.get<SettingsBloc>(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        builder: _builder,
        listener: _listener,
      ),
    );
  }

  Widget _builder(BuildContext context, SettingsState state) {
    int maxValue = SettingsBloc.initialMaxValue;
    int numberAttempts = SettingsBloc.initialNumberAttempts;

    if (state is SettingsInitial) {
      maxValue = state.maxValue;
      numberAttempts = state.numberAttempts;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Max value: $maxValue',
          style: const TextStyle(fontSize: 20.0),
        ),
        _maxValueSlider(
          value: maxValue,
          onChanged: (value) {
            context
                .read<SettingsBloc>()
                .add(OnChangeMaxValueEvent(value.toInt()));
          },
        ),
        Text(
          'Number attempts: $numberAttempts',
          style: const TextStyle(fontSize: 20.0),
        ),
        _numberAttemptsSlider(
          value: numberAttempts,
          onChanged: (value) {
            context
                .read<SettingsBloc>()
                .add(OnChangeNumberAttemptsEvent(value.toInt()));
          },
        ),
        AppTextButton(
          onPressed: () {
            context
                .read<SettingsBloc>()
                .add(const OnPressedLaunchButtonEvent());
          },
          text: 'Launch',
        ),
      ],
    );
  }

  void _listener(BuildContext context, SettingsState state) {
    if (state is LaunchGameState) {
      Navigator.popAndPushNamed(context, GuessNumberPage.route, arguments: false);
    }
  }

  Widget _maxValueSlider({
    required int value,
    required void Function(double) onChanged,
  }) {
    return Slider(
      label: 'Max Value: $value',
      value: value.toDouble(),
      onChanged: onChanged,
      min: 5,
      max: 100,
    );
  }

  Widget _numberAttemptsSlider({
    required int value,
    required void Function(double) onChanged,
  }) {
    return Slider(
      label: 'Number Attempts: $value',
      value: value.toDouble(),
      onChanged: onChanged,
      min: 5,
      max: 25,
    );
  }
}
