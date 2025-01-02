import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:solvo_flutter_assignment/presentation/guess_number/guess_number_bloc.dart';
import 'package:solvo_flutter_assignment/presentation/result/result_page.dart';
import 'package:solvo_flutter_assignment/presentation/settings/settings_page.dart';
import 'package:solvo_flutter_assignment/widgets/app_buttons.dart';

class GuessNumberPage extends StatelessWidget {
  static const String route = 'guess_number';

  const GuessNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector.appInstance.get<GuessNumberBloc>(),
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: _PageBody(),
        ),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuessNumberBloc, GuessNumberState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, GuessNumberState state) {
    var bloc = context.read<GuessNumberBloc>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _attemptsCounter(state),
        const Text("Enter number", style: TextStyle(fontSize: 25)),
        const SizedBox(height: 35),
        _AnswerNumberField(
          onTextChanged: (text) {
            bloc.add(OnTextChangedEvent(text));
          },
          onPressed: () {
            bloc.add(OnNumberEnterEvent());
          },
        ),
        const SizedBox(height: 35),
        AppTextButton(
          onPressed: (() {
            bloc.add(OnRestartEvent());
          }),
          text: 'Restart',
        ),
      ],
    );
  }

  void _listener(BuildContext context, GuessNumberState state) {
    if (state is GameEndState) {
      Navigator.popAndPushNamed(
        context,
        ResultPage.route,
        arguments: state.round,
      );
    } else if (state is RestartedState) {
      Navigator.popAndPushNamed(context, SettingsPage.route);
    }

    if (state is IncorrectAnswerState && state.isEmptyField) {
      final snackBar = SnackBar(
        content: const Text('Empty field'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        duration: const Duration(milliseconds: 250),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _attemptsCounter(GuessNumberState state) {
    if (state is InitialState || state is IncorrectAnswerState) {
      final int attemptsCount = (state as dynamic).attemptsCount;

      return Text('Attempts: $attemptsCount',
          style: const TextStyle(fontSize: 20));
    }

    return const SizedBox.shrink();
  }
}

class _AnswerNumberField extends StatelessWidget {
  final void Function() onPressed;
  final void Function(String) onTextChanged;

  const _AnswerNumberField({
    required this.onPressed,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: TextField(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            onChanged: onTextChanged,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onSubmitted: (value) {
              onPressed();
            },
          ),
        ),
        const SizedBox(width: 20),
        AppTextButton(
          onPressed: onPressed,
          text: 'GO',
          width: 45.0,
        ),
      ],
    );
  }
}
