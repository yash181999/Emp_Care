import 'package:flutter/material.dart';
import 'package:login/bottomNavigationbar/bottombar.dart';
import 'package:login/database/AuthService.dart';
import 'package:login/home/home.dart';
import 'package:login/login.dart';
import 'package:login/screens/chatbot.dart';
import 'package:login/screens/conference.dart';
import 'package:login/screens/request.dart';
import 'package:login/screens/splash_screen.dart';

void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool loggedIn = false;

  initState(){
     super.initState();
     checkLogin();

     Future.delayed(
       Duration(seconds: 3),
           () {

//
//            Navigator.pushReplacement(context, MaterialPageRoute(
//                builder : (context) => Login()
//            ));

         if(loggedIn == true) {
           Navigator.pushReplacement(context, MaterialPageRoute(
             builder: (context) => MainScreen(),
           ));
         }
         else{
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder : (context) => Login()
            ));
         }
//         else if(onBoarding == false && loggedIn == false) {
//           Navigator.pushReplacement(context,MaterialPageRoute(
//             builder: (context) => OnBoarding(),
//           ));
//         }
//         else{
//           Navigator.pushReplacement(context, MaterialPageRoute(
//             builder: (context) => BeforeLoginPage(),
//           ));
//         }


       },
     );

  }


  checkLogin() async{
       await  AuthService.getUserIdSharedPref().then((value) {
             setState(() {
               if(value!=null) {
                 loggedIn = true;
               }
             });
         });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }
}

