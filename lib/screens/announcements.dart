import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/color/color.dart';

class Announcements extends StatefulWidget {
  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         iconTheme: IconThemeData(
           color: black,
         ),
         title: Text(
             "Announcements",
             style : TextStyle(
               color: black,
             )
         ),
         backgroundColor: yellow,
       ),

      body: Container(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
           stream: Firestore.instance.collection("Announcement").orderBy("time",descending: true).snapshots(),
          builder: (context, snapshot){
             return snapshot.hasData ?
                 Column(
                   children: List.generate(snapshot.data.documents.length, (index) {
                     DocumentSnapshot doc = snapshot.data.documents[index];
                     print(snapshot.data.documents.length);

                     return Container(
                       child: Column(
                         children: [
                           Container(
                             width: MediaQuery.of(context).size.width,
                             padding: EdgeInsets.all(10),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Colors.blueAccent,
                             ),

                             child: Column(
                               children: [
                                 Text(
                                   doc['Announcement'].toString(),
                                   style: TextStyle(
                                       color: white,
                                       fontFamily: 'sf_pro_regular',
                                       fontSize: 18
                                   ),
                                 ),

                                 SizedBox(height: 20,),

                                 Container(
                                   alignment: Alignment.bottomCenter,
                                   child : Text(
                                       doc['time'],
                                     style: TextStyle(color: Colors.white),
                                   ),
                                 )

                               ],
                             ),

                           ),

                           SizedBox(height: 10,),
                         ],
                       ),
                     );
                   }),
             ):Container();
          }

        )
      ),
    );
  }
}
