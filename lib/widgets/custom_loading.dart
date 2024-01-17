import 'package:flutter/material.dart';
import 'package:user_app/constants/project_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:  CircularProgressIndicator(
        color: ProjectColors.red,
      ),
    );
  }
}