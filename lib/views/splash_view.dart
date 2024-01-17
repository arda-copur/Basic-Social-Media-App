import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/constants/project_images.dart';
import 'package:user_app/views/welcome.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
        backgroundColor: ProjectColors.white,
        splashScreenBody: SizedBox(
          child: Center(
              child: Image.asset(
            GifImageItems.splashBackground.gifPath,
            fit: BoxFit.cover,
          )),
        ),
        nextScreen: const WelcomeView(),
        duration: const Duration(milliseconds: 4000));
  }
}
