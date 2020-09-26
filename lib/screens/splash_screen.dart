import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child : Container(
         child :  Image(
            height: 400,
            image: AssetImage('assets/images/icon.png'),
          )
        )
      ),
    );
  }
}
