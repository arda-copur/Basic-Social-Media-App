import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_app/constants/project_texts.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmail(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createPerson(
      String username, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _firestore
        .collection(ProjectText.usersCollection)
        .doc(user.user?.uid ?? '')
        .set({'username': username, 'email': email, 'password': password});
    return user.user;
  }

  Future<String?> uploadProfileImage(String uid, File imageFile) async {
    try {
      var storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$uid');
      var uploadTask = storageRef.putFile(imageFile);
      await uploadTask.whenComplete(() {});
      var downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Profil resmi yüklenirken hata oluştu: $e");
      return null;
    }
  }

  Future<String?> getUserProfileImage() async {
    try {
      var user = await _auth.currentUser;
      if (user != null) {
        var snapshot = await _firestore
            .collection(ProjectText.usersCollection)
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          return snapshot.data()?['profileImageUrl'];
        }
      }
      return null;
    } catch (e) {
      print("Profil resmi alınırken hata oluştu: $e");
      return null;
    }
  }

  Future<String?> getUsername(String uid) async {
    try {
      var snapshot = await _firestore
          .collection(ProjectText.usersCollection)
          .doc(uid)
          .get();
      if (snapshot.exists) {
        return snapshot.data()?['username'];
      } else {
        return null;
      }
    } catch (e) {
      print("Kullanıcı adı alınırken hata oluştu: $e");
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      print("Bilgi bulunamadi");
      return null;
    }
  }

}
