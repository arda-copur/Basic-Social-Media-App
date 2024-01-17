import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/service/auth_service.dart';
import 'package:user_app/service/status_service.dart';
import 'package:user_app/views/add_status_view.dart';

abstract class AddStatusViewModel extends State<AddStatusView> {
  final TextEditingController statusController = TextEditingController();
  final StatusService statusService = StatusService();
  final AuthService authService = AuthService();
  final ImagePicker pickerImage = ImagePicker();

  String anlikKullanici = "";
  dynamic pickImage;
  dynamic statusImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    User? mevcutKullanici = await authService.getCurrentUser();
    if (mevcutKullanici != null) {
      String? kullaniciAdi = await authService.getUsername(mevcutKullanici.uid);
      setState(() {
        anlikKullanici = "$kullaniciAdi";
      });
    }
  }

  void imagePressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    try {
      final pickedFile = await pickerImage.pickImage(source: source);
      setState(() {
        statusImage = pickedFile!;
      });
    } catch (error) {
      setState(() {
        pickImage = error;
      });
    }
  }

  DelightToastBar toastBar(String text) {
    return DelightToastBar(
        autoDismiss: true,
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

  void saveButtonOnTap() {
    if (statusController.text.isNotEmpty && statusImage != null) {
      setState(() {
        isLoading = true;
      });
      statusService
          .addStatus(statusController.text, statusImage, anlikKullanici ?? '')
          .then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        toastBar("Bir hata yaşandı");
      }).whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      toastBar("Beklenmedik hata");
    }
  }
}
