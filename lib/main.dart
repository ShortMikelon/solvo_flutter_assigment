import 'package:flutter/material.dart';
import 'package:solvo_flutter_assignment/di.dart';
import 'package:solvo_flutter_assignment/domain/entities/round.dart';
import 'package:solvo_flutter_assignment/presentation/guess_number/guess_number_page.dart';
import 'package:solvo_flutter_assignment/presentation/home/home_page.dart';
import 'package:solvo_flutter_assignment/presentation/result/result_page.dart';
import 'package:solvo_flutter_assignment/presentation/settings/settings_page.dart';

void main() {
  DependencyInjector.configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (context) => const HomePage(),
        SettingsPage.route: (context) => const SettingsPage(),
        GuessNumberPage.route: (context) => const GuessNumberPage(),
      },
      onGenerateRoute: ((settings) {
        if (settings.name == ResultPage.route) {
          final Round arg = settings.arguments as Round;

          return MaterialPageRoute(
            builder: (context) => const ResultPage(),
            settings: RouteSettings(arguments: arg),
          );
        }

        return null;
      }),
    );
  }
}
