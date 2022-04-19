import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:video_player_app/src/app_module.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Video Player App',
      theme: ThemeData(primarySwatch: Colors.green),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
