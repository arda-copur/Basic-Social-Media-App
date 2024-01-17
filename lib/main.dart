import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_app/constants/project_init.dart';
import 'package:user_app/views/splash_view.dart';
import 'constants/project_colors.dart';

void main() {
  ProjectStart.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ProjectColors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const SplashView(),
    );
  }
}
