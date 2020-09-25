

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  Firestore db = Firestore.instance;


   Future<dynamic> getUserDataFromFireStore({String userId}) async{
    List<String> userData;

    await db.collection("Users").document(userId).get().then((value){

      userData.add(value.data['name'].toString());
//      userData.add(value.data['profilePic']);
      userData.add(value.data['email']);
      userData.add(value.data['idProof']);
      userData.add(value.data['phone']);
      userData.add(value.data['address']);
      return userData;

    });

  }

}