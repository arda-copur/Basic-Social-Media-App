import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


@immutable
 class ProjectStart {
  const ProjectStart._();
   static void init() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   }
 }
