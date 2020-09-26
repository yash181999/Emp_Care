import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/database/AuthService.dart';
import 'package:login/database/firestore.dart';
import 'package:login/profile/profile.dart';
import 'package:login/screens/chatbot.dart';
import 'package:login/screens/conference.dart';
import 'package:login/screens/feedback.dart';
import 'package:login/screens/request.dart';
import 'package:login/screens/task.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {

  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }


  String userId;
  dynamic data;

  getUserInfo() async{

    await AuthService.getUserIdSharedPref().then((value) {
        setState(() {
          userId = value;
        });
    });

    print(userId);


    try {
      List userData = new List();
      await Firestore.instance.collection("Users").document(userId).get().then((value) {
         if(value!=null) {
           userData.add(value.data['name']);
           userData.add(value.data['email']);
           userData.add(value.data['email']);
           userData.add(value.data['idProof']);
           userData.add(value.data['phone']);
           userData.add(value.data['address']);
           userData.add(value.data['profilePic']);
           AuthService.saveUserNameSharedPref(value.data['name']);

         }




      });

      setState(() {
        data = userData;
      });
    } on Exception catch (e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  Text(
                    "My Profile",
                    style: TextStyle(
                        fontFamily: "sf_pro_medium",
                        fontSize: 23
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Profile(userId : userId),
                      ));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:  AssetImage('assets/images/dummy_profile.jpg') ,
                            backgroundColor: Colors.green,
                            // backgroundImage: AssetImage('images/batman.jpg'),
                          ),
                          SizedBox(width: 30,),
                          Column(
                            children: [
                              Text(
                                data != null ? data[0] : "UserName",
                                style: TextStyle(
                                    fontFamily: "sf_pro_medium",
                                    fontSize: 20
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                data !=null ? data[1] : "Email",
                                style: TextStyle(
                                    fontFamily: "sf_pro_medium",
                                    fontSize: 12
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),



          ListTile(
            leading: Icon(Icons.border_color , color: Colors.black,),
            title: Text('Feedback', style: TextStyle(fontFamily: "sf_pro_medium", color: Colors.black),),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBack()))},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app , color: Colors.black,),
            title: Text('Logout',style: TextStyle(fontFamily: "sf_pro_medium", color: Colors.black),),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
