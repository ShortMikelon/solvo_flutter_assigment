import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:solvo_flutter_assignment/presentation/guess_number/guess_number_bloc.dart';
import 'package:solvo_flutter_assignment/presentation/result/result_page.dart';
import 'package:solvo_flutter_assignment/widgets/app_buttons.dart';

class GuessNumberPage extends StatelessWidget {
  static const String route = 'guess_number';

  const GuessNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: _PageBody(),
      ),
    );
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

class _PageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector.appInstance.get<GuessNumberBloc>(),
      child: BlocConsumer<GuessNumberBloc, GuessNumberState>(
        builder: _builder,
        listener: _listener,
      ),
    );
  }

  Widget _builder(BuildContext context, GuessNumberState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _getTitle(state),
        const Text("Enter number", style: TextStyle(fontSize: 25)),
        const SizedBox(height: 35),
        _AnswerNumberField(
          onTextChanged: (text) {
            context.read<GuessNumberBloc>().add(OnTextChangedEvent(text));
          },
          onPressed: () {
            context.read<GuessNumberBloc>().add(OnNumberEnterEvent());
          },
        ),
        const SizedBox(height: 35),
        AppTextButton(
          onPressed: () =>
              context.read<GuessNumberBloc>().add(OnRestartEvent()),
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
    }
  }

  Widget _getTitle(GuessNumberState state) {
    if (state is IncorrectAnswerState) {
      return const Text('Incorrect');
    } else if (state is RestartedState) {
      return const Text('Restarted');
    } else {
      return const Text('Initial');
    }
  }
}
