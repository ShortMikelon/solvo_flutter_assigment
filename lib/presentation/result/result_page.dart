import 'package:flutter/material.dart';
import 'package:solvo_flutter_assignment/presentation/settings/settings_page.dart';
import 'package:solvo_flutter_assignment/widgets/app_buttons.dart';

import '../../domain/entities/round.dart';

class ResultPage extends StatelessWidget {
  static const String route = '/result';

  // final Round _round;

  // const ResultPage({
  //   super.key,
  //   required Round round,
  // }) : _round = round;

  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: const _PageBody(),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context) {
    Round arg = ModalRoute.of(context)?.settings.arguments as Round;

    String resultText = 'win';
    if (arg.status == RoundStatus.win) {
      resultText = 'win';
    } else {
      resultText = 'Lose';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          resultText,
          style: const TextStyle(fontSize: 20.0),
        ),
        AppTextButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, SettingsPage.route);
          },
          text: 'Restart',
          height: 40,
        ),
      ],
    );
  }
}
