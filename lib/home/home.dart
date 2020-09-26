import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/bottomNavigationbar/bottombar.dart';
import 'package:login/color/color.dart';
import 'package:login/database/AuthService.dart';
import 'package:login/database/firestore.dart';
import 'package:login/screens/announcements.dart';
import 'package:login/sideNavBar/sideNavBar.dart';
import 'package:login/widgets/listItems.dart';
import 'package:login/widgets/top_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();

  }

  dynamic userData;
  String userId;

  getUserData() async {
    await AuthService.getUserIdSharedPref().then((value) {
      setState(() {
        userId = value;
      });
    });


    print(userId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              image: AssetImage("assets/logo.png"),
              fit: BoxFit.contain,
              height: 32,
            ),
            SizedBox(width: 65,),
            Icon(
              Icons.notifications
            )
          ],
        ),
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20,),
              //announcement card...
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TopCard(
                      title: "ANNOUNCEMENT",
                      subTitle: "Check daily announcements",
                      btnColor: red,
                      cardColor: yellow,
                      btnText: "CHECK",
                      onPressed: (){
                         Navigator.push(context, MaterialPageRoute(
                            builder : (context) => Announcements(),
                         ));
                      },
                      icon:  Container(
                        alignment: Alignment.centerLeft,
                        child: Image(
                          height: 40,
                          image: AssetImage('assets/icons/announcement.png'),
                        ),
                      ),
                    ),

                  ],
                ),
              ),


              SizedBox(height: 20,),
                // recently added container
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                    ),
                    Icon(
                      Icons.wrap_text,

                    )
                  ],
                ),
              ),

              SizedBox(height: 30,),



              StreamBuilder(

                stream : Firestore.instance.collection("Meeting").where("status", isEqualTo: "online").snapshots(),

                builder: (context, snapshot) {
                  return snapshot.hasData ? Column(
                    children: List.generate(snapshot.data.documents.length, (index) {
                       DocumentSnapshot doc = snapshot.data.documents[index];
                         return Column(
                            children: [
                              ListItems(
                                color: Colors.blue,
                                title: "Meeting Id  copy it and paste it in conference :  ${doc['meetingId'].toString()} ",
                                titleColor: white,
                              ),
                              SizedBox(height: 10,),
                            ],
                         );
                      }),

                  ) : Container();
                }
              ),

              SizedBox(height : 20),


              StreamBuilder(

                  stream : Firestore.instance.collection("Tasks").where("userId",isEqualTo:userId).snapshots(),

                  builder: (context, snapshot) {
                    return snapshot.hasData ? Column(
                      children: List.generate(snapshot.data.documents.length, (index) {
                        DocumentSnapshot doc = snapshot.data.documents[index];
                        return Column(
                          children: [
                            ListItems(
                              color: Colors.blue,
                              title: doc['Task'],
                              titleColor: white,
                            ),
                            SizedBox(height: 10,),
                          ],
                        );
                      }),

                    ) : Container();
                  }
              ),







              // task assigned
//
//              Container(
//                margin: EdgeInsets.symmetric(horizontal: 20),
//                decoration: BoxDecoration(
//                  color: Colors.greenAccent,
//                  borderRadius: BorderRadius.circular(20),
//                ),
//                height: 70,
//                width: MediaQuery.of(context).size.width,
//              ),
//
//              SizedBox(height: 20,),
//
//              Container(
//                margin: EdgeInsets.symmetric(horizontal: 20),
//                decoration: BoxDecoration(
//                  color: Colors.purpleAccent,
//                  borderRadius: BorderRadius.circular(20),
//                ),
//                height: 70,
//                width: MediaQuery.of(context).size.width,
//              ),
//
//              SizedBox(height: 20,),
//
//              Container(
//                margin: EdgeInsets.symmetric(horizontal: 20),
//                decoration: BoxDecoration(
//                  color: Colors.grey,
//                  borderRadius: BorderRadius.circular(20),
//                ),
//                height: 70,
//                width: MediaQuery.of(context).size.width,
//              ),
//
//              SizedBox(height: 20,),
//
//              Container(
//                margin: EdgeInsets.symmetric(horizontal: 20),
//                decoration: BoxDecoration(
//                  color: Colors.deepOrangeAccent,
//                  borderRadius: BorderRadius.circular(20),
//                ),
//                height: 70,
//                width: MediaQuery.of(context).size.width,
//              ),
            ],
          ),
        ),
      ),

    );
  }
}
