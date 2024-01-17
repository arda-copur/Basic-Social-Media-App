import 'package:flutter/material.dart';
import 'package:user_app/constants/project_borders.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/constants/project_images.dart';
import 'package:user_app/constants/project_paddings.dart';
import 'package:user_app/constants/project_texts.dart';
import 'package:user_app/view_models/register_view_model.dart';
import 'package:user_app/views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends RegisterViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundImage(),
          welcomeTitle(context),
          registerMenu(context)
        ],
      ),
    );
  }

   Padding welcomeTitle(BuildContext context) {
    return Padding(
      padding: const ProjectPaddings.registerOnly(),
      child: Text(
        ProjectText.welcomeText,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ProjectColors.white,
            fontWeight: FontWeight.w800,
            fontSize: 34),
      ),
    );
  }

  Center registerMenu(BuildContext context) {
    return Center(
      child: Padding(
        padding: const ProjectPaddings.registerOnlyTop(),
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
                color: ProjectColors.black.withOpacity(0.4),
                shape: BoxShape.rectangle,
                borderRadius: ProjectBorders.normalCircular(),
                border: Border.all(color: ProjectColors.black)),
            child: Padding(
              padding: const ProjectPaddings.mediumPadding(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    ProjectText.accountText,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ProjectColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myTextField(
                    usernameController,
                    'Kullanıcı adı',
                    const Icon(Icons.account_circle_rounded),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  myTextField(
                      emailController, 'Email', const Icon(Icons.email)),
                  const SizedBox(
                    height: 12,
                  ),
                  myTextField(
                      passwordController,
                      'Şifre',
                      showWords: true,
                      const Icon(Icons.lock)),
                  const SizedBox(
                    height: 30,
                  ),
                  profileImageButton(context),
                  const SizedBox(height: 10),
                  myLoginButton(context),
                  const SizedBox(height: 30),
                  Text(
                    ProjectText.hasAccountText,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ProjectColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  goToLoginButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Image backgroundImage() {
    return Image.asset(
      GifImageItems.coffeGirl.gifPath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  ElevatedButton myLoginButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ProjectColors.primaryColor,
          elevation: 5,
          foregroundColor: ProjectColors.red,
          padding: const ProjectPaddings.registerOnlyThird(),
        ),
        onPressed: () {
          registerPressed();
        },
        child: Text(
          ProjectText.createAccountText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ProjectColors.white, fontWeight: FontWeight.w800),
        ));
  }

  InkWell goToLoginButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginView()));
      },
      child: Text(
        ProjectText.loginText,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ProjectColors.white,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }

  TextField myTextField(
      TextEditingController controller, String myHintText, Icon myPrefixIcon,
      {bool showWords = false}) {
    return TextField(
      obscureText: showWords,
      controller: controller,
      style: TextStyle(
          color: ProjectColors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12),
      decoration: InputDecoration(
          focusColor: ProjectColors.primaryColor,
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
      cursorColor: ProjectColors.primaryColor,
    );
  }

  ElevatedButton profileImageButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ProjectColors.primaryColor,
          elevation: 5,
          foregroundColor: ProjectColors.red,
          padding: const ProjectPaddings.registerOnlyThird(),
        ),
        onPressed: () {
          pickImage();
        },
        child: Text(
          ProjectText.profileImageText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ProjectColors.white, fontWeight: FontWeight.w800),
        ));
  }
}
