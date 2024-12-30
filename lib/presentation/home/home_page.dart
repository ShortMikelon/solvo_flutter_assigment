import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:solvo_flutter_assignment/presentation/guess_number/guess_number_page.dart';
import 'package:solvo_flutter_assignment/presentation/home/home_bloc.dart';
import 'package:solvo_flutter_assignment/presentation/settings/settings_page.dart';
import 'package:solvo_flutter_assignment/widgets/app_buttons.dart';

class HomePage extends StatelessWidget {
  static const String route = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector.appInstance.get<HomeBloc>(),
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: const _HomeDisplay(),
        ),
      ),
    );
  }
}

class _HomeDisplay extends StatelessWidget {
  const _HomeDisplay();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(BuildContext context, HomeState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Home Page', style: TextStyle(fontSize: 20)),
        AppTextButton(
          onPressed: () {
            Navigator.pushNamed(context, SettingsPage.route);
          },
          text: 'Start',
          width: 130,
          height: 40,
        ),
      ],
    );
  }

  void _listener(BuildContext context, HomeState state) {
    if (state is LaunchGameState) {
      Navigator.pushNamed(context, SettingsPage.route);
    } else if (state is ContinueGameState) {
      Navigator.pushNamed(
        context,
        GuessNumberPage.route,
        arguments: true,
      );
    }
  }
}
