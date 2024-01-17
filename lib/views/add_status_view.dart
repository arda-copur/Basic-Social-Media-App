import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/constants/project_borders.dart';
import 'package:user_app/constants/project_colors.dart';
import 'package:user_app/constants/project_paddings.dart';
import 'package:user_app/constants/project_texts.dart';
import 'package:user_app/view_models/add_status_view_model.dart';

class AddStatusView extends StatefulWidget {
  const AddStatusView({super.key});

  @override
  State<AddStatusView> createState() => _AddStatusViewState();
}

class _AddStatusViewState extends AddStatusViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ProjectColors.primaryColor,
        centerTitle: true,
        title: Text(
          ProjectText.projectTitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: ProjectColors.white),
        ),
      ),
      body: _body(),
    );
  }

  Stack _body() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _mainBody(),
              _saveButton(context),
            ],
          ),
        ),
        if (isLoading) customLoading(),
      ],
    );
  }

  Flexible _mainBody() {
    return Flexible(
      child: ListView(
        children: [
          _bodyTitle(),
          const SizedBox(
            height: 20,
          ),
          _bodyImage(),
          const SizedBox(
            height: 30,
          ),
          _bodyContainer(),
        ],
      ),
    );
  }

  Widget _bodyTitle() {
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const ProjectPaddings.highPadding(),
        child: Text(ProjectText.questionText),
      ),
    );
  }

  Container _bodyContainer() {
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const ProjectPaddings.highPadding(),
        child: _statusTextField(),
      ),
    );
  }

  TextField _statusTextField() {
    return TextField(
        cursorColor: ProjectColors.amber,
        controller: statusController,
        maxLines: 7,
        decoration: InputDecoration(
          hintText: ProjectText.detailText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ProjectColors.white,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ProjectColors.white,
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ProjectColors.white,
            ),
          ),
        ));
  }

  Column _bodyImage() {
    return Column(
      children: [
        Center(
          child: _imagePlace(),
        ),
        const SizedBox(
          height: 10,
        ),
        _imageRow(),
      ],
    );
  }

  Row _imageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _cameraContainer(),
        const SizedBox(
          width: 10,
        ),
        _galeryContainer(),
      ],
    );
  }

  Container _cameraContainer() {
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        icon: Icon(
          Icons.camera_alt,
          color: ProjectColors.amber,
        ),
        onPressed: () => imagePressed(
          ImageSource.camera,
          context: context,
        ),
      ),
    );
  }

  Container _galeryContainer() {
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        icon: Icon(
          Icons.image,
          color: ProjectColors.amber,
        ),
        onPressed: () => imagePressed(
          ImageSource.gallery,
          context: context,
        ),
      ),
    );
  }

  Container _imagePlace() {
    if (statusImage != null) {
      return _uploadedImageContainer();
    } else {
      if (pickImage != null) {
        return _networkImage();
      } else {
        return _circleImage();
      }
    }
  }

  Container _uploadedImageContainer() {
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const ProjectPaddings.customAll(),
        child: ClipRRect(
          borderRadius: ProjectBorders.mediumCircular(),
          child: Image.file(
            File(statusImage!.path),
          ),
        ),
      ),
    );
  }

  Container _networkImage() {
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const ProjectPaddings.customAll(),
        child: ClipRRect(
            borderRadius: ProjectBorders.mediumCircular(),
            child: Image.network(pickImage)),
      ),
    );
  }

  Container _circleImage() {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: ProjectColors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const ProjectPaddings.customAll(),
        child: CircleAvatar(
          backgroundImage: const AssetImage("assets/add_status_image.png"),
          radius: height * 0.08,
        ),
      ),
    );
  }

  Padding _saveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
          onTap: () => saveButtonOnTap(),
          child: Container(
            decoration: BoxDecoration(
                color: ProjectColors.primaryColor,
                borderRadius: ProjectBorders.lowCircular()),
            height: 40,
            child: Center(
              child: Text(
                ProjectText.shareText,
                style: TextStyle(
                  color: ProjectColors.white,
                ),
              ),
            ),
          )),
    );
  }
}
