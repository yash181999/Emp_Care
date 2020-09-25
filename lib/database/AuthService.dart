import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firestore.dart';

class AuthService{
  FirebaseAuth _auth  = FirebaseAuth.instance;
  DatabaseService databaseService = DatabaseService();

  static String sharedPrefUserName = "userName";
  static String sharedPrefUserId = "userId";
  static String sharedPrefOnBoardingScreenSeen = "onBoardingScreen";



  //singn in with email password..


  Future signInUserWithEmailAndPassword(String email, String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user  = result.user;
      return user.uid;
    }
    catch(e) {
      print(e.toString());
      return e;
    }
  }

  static Future<void> saveUserNameSharedPref(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefUserName, userName);

  }

  static Future<void> saveUserIdSharedPref(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefUserId, userId);

  }


  static Future<String> getUserNameSharePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPrefUserName);

  }

  static Future<String> getUserIdSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPrefUserId);

  }

  static Future setOnBoardingSeenToSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(sharedPrefOnBoardingScreenSeen, true);
  }

  static Future<bool> getOnBoardingScreenSeenSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPrefOnBoardingScreenSeen);
  }


}


