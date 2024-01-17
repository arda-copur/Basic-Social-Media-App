import 'package:flutter/material.dart';
import 'package:user_app/constants/project_borders.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/constants/project_images.dart';
import 'package:user_app/constants/project_paddings.dart';
import 'package:user_app/constants/project_texts.dart';
import 'package:user_app/views/login_view.dart';
import 'package:user_app/views/register_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.primaryColor,
        centerTitle: true,
        title: Text(
          ProjectText.projectTitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
      body: _body(context),
    );
  }

  Padding _body(BuildContext context) {
    return Padding(
        padding: const ProjectPaddings.customSymmetric(),
        child: ListView(
          children: [
            _myLogoImage(context),
            const SizedBox(
              height: 50,
            ),
            _myColumn(context),
          ],
        ));
  }

  ClipRRect _myLogoImage(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: ProjectBorders.mediumCircular(),
      child: Image.asset(
        GifImageItems.onerioHome.gifPath,
        height: size.height * .5,
        fit: BoxFit.fill,
      ),
    );
  }

  Column _myColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _myLoginButton(context),
        const SizedBox(
          height: 15,
        ),
        _myRegisterButton(context),
      ],
    );
  }

  InkWell _myLoginButton(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginView()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: ProjectColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          child: Center(
            child: Text(ProjectText.loginText,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: ProjectColors.white)),
          ),
        ));
  }

  InkWell _myRegisterButton(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterView()));
        },
        child: Container(
          decoration: BoxDecoration(
              color: ProjectColors.primaryColor,
              borderRadius: ProjectBorders.lowCircular()),
          height: 40,
          child: Center(
            child: Text(ProjectText.registerText,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: ProjectColors.white)),
          ),
        ));
  }
}
