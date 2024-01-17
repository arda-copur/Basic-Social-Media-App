import 'package:flutter/material.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/constants/project_images.dart';
import 'package:user_app/constants/project_paddings.dart';
import 'package:user_app/constants/project_texts.dart';
import 'package:user_app/view_models/login_view_model.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends LoginViewModel{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const ProjectPaddings.customTRB(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Container(
                  decoration: BoxDecoration(
                      color: ProjectColors.primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const ProjectPaddings.highPadding(),
                    child: SingleChildScrollView(
                      child: loginMenu(),
                    ),
                  ),
                )),
                if (isLoading) customLoading(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column loginMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myTextField(emailController, "Email", const Icon(Icons.email)),
        const SizedBox(
          height: 20,
        ),
        myTextField(
            passwordController,
            "Şifre",
            showWords: true,
            const Icon(Icons.lock_rounded)),
        const SizedBox(
          height: 20,
        ),
        _loginButton(),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          GifImageItems.loginView.gifPath,
          fit: BoxFit.cover,
        )
      ],
    );
  }

  TextField myTextField(
      TextEditingController controller, String myHintText, Icon myPrefixIcon,
      {bool showWords = false}) {
    return TextField(
      controller: controller,
      obscureText: showWords,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: ProjectColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          enabled: true,
          focusColor: ProjectColors.amber,
          hoverColor: ProjectColors.transparent,
          filled: true,
          fillColor: ProjectColors.white.withOpacity(0.5),
          hintText: myHintText,
          prefixIcon: myPrefixIcon,
          prefixIconColor: ProjectColors.primaryColor,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ProjectColors.primaryColor, width: 3),
              borderRadius: const BorderRadius.all(Radius.circular(18)))),
      cursorColor: ProjectColors.amber,
    );
  }

  InkWell _loginButton() {
    return InkWell(
      onTap: () => loginWithEmail(),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: ProjectColors.amber,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            ProjectText.logText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ProjectColors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }



}
