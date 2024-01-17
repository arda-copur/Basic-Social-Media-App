import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/constants/project_texts.dart';
import 'package:user_app/service/auth_service.dart';
import 'package:user_app/views/register_view.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:user_app/views/welcome.view.dart';

abstract class RegisterViewModel extends State<RegisterView> {

  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _image;
  bool isLoading = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        toastBar("Fotoğraf seçmediniz");
      }
    });
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

  void registerPressed() async {
    if (usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        _image != null) {
      setState(() {
        isLoading = true;
      });

      try {
        var user = await _authService.createPerson(
          usernameController.text,
          emailController.text,
          passwordController.text,
        );

        if (user != null) {
          var imageUrl =
              await _authService.uploadProfileImage(user.uid, _image!);

          await _firestore
              .collection(ProjectText.usersCollection)
              .doc(user.uid)
              .set(
            {
              'username': usernameController.text,
              'email': emailController.text,
              'password': passwordController.text,
              'profileImageUrl': imageUrl,
            },
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeView()),
            (route) => false,
          );
        } else {
          toastBar("İşlem tamamlanamadı");
        }
      } catch (error) {
        toastBar("İşlem tamamlanamadı");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      toastBar("Eksik bilgi");
    }
  }
}
