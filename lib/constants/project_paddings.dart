import 'package:flutter/material.dart';

class ProjectPaddings extends EdgeInsets {
  //Project 
  const ProjectPaddings.normalPadding() : super.all(8);
  const ProjectPaddings.mediumPadding() : super.all(12);
  const ProjectPaddings.highPadding() : super.all(20);
  //Welcome
  const ProjectPaddings.customSymmetric() : super.symmetric(horizontal: 20,vertical: 50);
  //Register
  const ProjectPaddings.registerOnly() : super.only(top: 140,left: 20);
  const ProjectPaddings.registerOnlyTop() : super.only(top: 100);
  const ProjectPaddings.registerOnlyThird() : super.only(top: 5,right: 18,left: 18,bottom: 5);
  //Login
  const ProjectPaddings.customTRB() : super.fromLTRB(20, 110, 20, 30);
  //Add Status
  const ProjectPaddings.customAll() : super.all(10);

}