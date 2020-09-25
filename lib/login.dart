import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/database/firestore.dart';
import 'package:login/services/auth.dart';

import 'bottomNavigationbar/bottombar.dart';
import 'database/AuthService.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  AuthMethod authMethod = new AuthMethod();
  final formKey = GlobalKey<FormState>();
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();


  bool clickedLoginBtn  = false;

  bool wrongPassword = false;
  bool wrongEmail = false;

  loginFirebase() async {
      String email = emailTextEditingController.text;
      String password = passwordTextEditingController.text;

      dynamic result = await authService.signInUserWithEmailAndPassword(email, password);
      print(result);

      if(result.toString().contains("password is invalid")) {
         setState(() {
             wrongPassword = true;
             clickedLoginBtn = false;
         });

      }
       else if(result.toString().contains("There is no user record")) {
         setState(() {
           wrongEmail = true;
           clickedLoginBtn = false;
         });
      }
      else if(result.toString().contains("There is no user record") && result.toString().contains("password is invalid")) {
        setState(() {
          wrongPassword = true;
          wrongEmail = true;
          clickedLoginBtn = false;
        });
      }
      else{
        await AuthService.saveUserIdSharedPref(result.toString());
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));
        clickedLoginBtn = false;

      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        child: Stack(
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  "WELCOME !",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'sf_pro_semi_bold',

                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.380,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                ),
              ),
            ),

            // login Box

            Center(
              child: Container(
                height: MediaQuery.of(context).size.height*0.60,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Text(
                     "LOG IN",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "sf_pro_semi_bold",
                        fontSize: 20
                      ),
                    ),

                    SizedBox(height: 20,),

                    wrongPassword == true ? Text(
                       "Wrong Password",
                        style : TextStyle(
                          color: Colors.red,
                        )
                    ) : Container(),


                    wrongEmail == true ? Text(
                        "No user Exist with this email",
                        style : TextStyle(
                          color: Colors.red,
                        )
                    ) : Container(),


                    SizedBox(height: 50,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style : TextStyle(
                                fontSize: 18,
                                fontFamily: 'sf_pro_bold'
                              ),
                              validator: (value) {
                                if(value.isEmpty) {
                                  return "Field should not be empty";
                                }
                                if(!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$").hasMatch(value)) {
                                  return "Invalid Email";
                                }
                                if(wrongEmail == true) {
                                  return "No user Exist with this email";
                                }
                                return null;
                              },
                              controller: emailTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black54),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black54),
                                  )
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              obscureText: true,
                              style : TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'sf_pro_bold'
                              ),
                              validator: (val) {
                                 if((val.isEmpty)) {
                                   return "Field should not be empty";
                                 }
                                 if(wrongPassword == true) {
                                   return "Wrong Password";
                                 }
                                 return null;
                              },
                              controller: passwordTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black54),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black54),
                                  )
                              ),

                            ),
                            SizedBox(height: 10,),
                            Container(
                              padding : EdgeInsets.only(top: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Forgot your password ?",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: "sf_pro_bold",
                                    fontSize: 14
                                ),
                              ),
                            ),

                            SizedBox(height: 60,),


                            Container(
                              alignment : Alignment.bottomCenter,
                              child: Container(

                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color : Colors.blue,
                                  ),
                                  //login btn
                                  child : clickedLoginBtn == false ?  IconButton(
                                      onPressed: (){

                                          if(formKey.currentState.validate()){
                                              setState(() {
                                                clickedLoginBtn =  true;
                                                wrongPassword = false;
                                                wrongEmail = false;
                                              });

                                              loginFirebase();
                                          }

                                      },
                                      icon : Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      )
                                  ) : CircularProgressIndicator(),
                              ),
                            )

                          ],
                        ),
                      ),

                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 80),
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5
                  ),]
                ),
              ),
            ),

            // circle on login Box
//            Container(
//              margin: EdgeInsets.only(top: 500),
//              padding: EdgeInsets.symmetric(vertical: 10),
//              child: Container(
//                child: Center(
//                  child: Icon(
//                    Icons.arrow_forward,
//                  color: Colors.white,
//                  size: 30,),
//                ),
//
//                decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    color: Colors.deepPurpleAccent,
//                ),
//              ),
//            )







          ],
        ),

      ),


    );
  }
}
