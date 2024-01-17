
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/constants/project_texts.dart';
import 'package:user_app/model/status_model.dart';
import 'package:user_app/service/storage_service.dart';

class StatusService{
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final StorageService _firebaseStorage = StorageService();



   Future<Status> addStatus(String status, XFile pickedFile,String personName) async{
          var ref = _firestore.collection(ProjectText.statusCollection); 

          var mediaUrl = await _firebaseStorage.uploadMedia(File(pickedFile.path)); 

          var documentRef = await ref.add({'status': status, 'image': mediaUrl,'anlikKullanici': personName});  

          return Status(id: documentRef.id, status: status, image: mediaUrl,personName: personName); 
         
   }


     Stream<QuerySnapshot>  getStatus() {
      var _ref = _firestore.collection(ProjectText.statusCollection).snapshots(); 
        return  _ref;
     }

  
}

