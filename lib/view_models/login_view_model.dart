import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/service/auth_service.dart';
import 'package:user_app/views/home_view.dart';
import 'package:user_app/views/login_view.dart';
abstract class LoginViewModel extends State<LoginView> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

 final AuthService authService = AuthService();

 
  void loginWithEmail() {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      authService
          .signInWithEmail(emailController.text, passwordController.text)
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
            (route) => false);
      }).catchError((error) {
        if (error.toString().contains('invalid-email')) {
          toastBar("Geçersiz mail adresi");
        } else if (error.toString().contains('user-not-found')) {
          toastBar("Kullanıcı bulunamadı");
        } else if (error.toString().contains('wrong-password')) {
          toastBar("Yanlış şifre");
        } else {
          toastBar("Beklenmedik bir hata oluştu");
        }
      }).whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      toastBar("Eksik bilgi");
    }
  }

    DelightToastBar toastBar(String text) {
    return DelightToastBar(
        builder: (context) => ToastCard(
                title: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: ProjectColors.red),
            )));
  }

    Center customLoading() {
    return Center(
      child: CircularProgressIndicator(color: ProjectColors.red),
    );
  }


}