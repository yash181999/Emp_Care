import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/color/color.dart';
import 'package:login/profile/edit_password.dart';

import 'editProfile.dart';

class Profile extends StatefulWidget {
  final dynamic userId;
  Profile({this.userId});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileDetails();
  }

  String profilePic, name, email, address, idProof, phone,leaves;



  getProfileDetails() {
     Firestore.instance.collection("Users").document(widget.userId).get().then((value){

         setState(() {
            profilePic = value.data['profilePic'];
            name = value.data['name'];
            email = value.data['email'];
            address = value.data['address'];
            phone = value.data['phone'];
            idProof= value.data['idProof'];
            leaves = value.data['leavesRemaining'];
         });

     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),

      body: Container(
        padding: EdgeInsets.all(10),
        child: name!=null? SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:  Column(
             children: [
               Container(
                 height: MediaQuery.of(context).size.height*0.35,

                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   color: blue,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Column(
                   children: [
                     SizedBox(height: 30,),
                     InkWell(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(
                             builder:  (context) => EditProfile(
                               userId: widget.userId,
                               phone: phone,
                                profilePic: profilePic,
                               address: address,
                             ),
                         ));
                       },
                       child: CircleAvatar(
                         radius:40,
                         backgroundImage: profilePic==null ?  AssetImage(
                           'assets/images/add_image.png'
                         ):NetworkImage(profilePic),
                       ),
                     ),


                     SizedBox(height: 10,),

                     Container(
                       alignment: Alignment.center,
                       child: Text(
                         ' ${name} ',
                         style: TextStyle(
                           fontSize: 25,
                           fontFamily: 'sf_pro_bold',
                         ),
                       ),
                     ),


                     Container(
                       alignment: Alignment.center,
                       child: Text(
                         ' ${email} ',
                         style: TextStyle(
                           fontSize: 18,
                           fontFamily: 'sf_pro_bold',
                         ),
                       ),
                     ),


                     SizedBox(height: 20,),

                     RaisedButton(
                       onPressed: (){
                         Navigator.push(context, MaterialPageRoute(
                           builder:  (context) => EditProfile(
                              userId: widget.userId,
                              address: address,
                              profilePic: profilePic,
                              phone: phone,
                           ),
                         ));
                       },
                       color: Colors.blueAccent,
                       child: Text(
                           "Edit Profile",
                         style:TextStyle(
                           color: white,
                         )
                       ),
                     )


                   ],
                 ),
               ),



               SizedBox(height: 20,),

               Container(
                 width: MediaQuery.of(context).size.width,
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   color: blue,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Column(
                   children: [
                     Text(
                         "ADDRESS",
                         style: TextStyle(
                           color: Colors.black,
                           fontFamily: 'sf_pro_bold',
                           fontSize: 18
                         ),
                     ),
                     SizedBox(height: 5,),
                     Text(
                         address,
                       style: TextStyle(
                           color: Colors.black,
                           fontFamily: 'sf_pro_semi_bold',
                           fontSize: 18
                       ),
                     )
                   ],
                 ),
               ),
               SizedBox(height: 20,),
               Container(
                 width: MediaQuery.of(context).size.width,
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   color: blue,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Column(
                   children: [
                     Text(
                       "Mobile Number",
                       style: TextStyle(
                           color: Colors.black,
                           fontFamily: 'sf_pro_bold',
                           fontSize: 18
                       ),
                     ),
                     SizedBox(height: 5,),
                     Text(
                       phone,
                       style: TextStyle(
                           color: Colors.black,
                           fontFamily: 'sf_pro_semi_bold',
                           fontSize: 18
                       ),
                     )
                   ],
                 ),
               ),
               SizedBox(height: 20,),

               Container(
                 width: MediaQuery.of(context).size.width,
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   color: blue,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Column(
                   children: [
                     Text(
                       "ID PROOF",
                       style: TextStyle(
                           color: Colors.black,
                           fontFamily: 'sf_pro_bold',
                           fontSize: 18
                       ),
                     ),
                     SizedBox(height: 5,),
                     Text(
                       idProof,
                       style: TextStyle(
                           color: Colors.black,
                           fontFamily: 'sf_pro_semi_bold',
                           fontSize: 18
                       ),
                     )
                   ],
                 ),
               ),
               SizedBox(height: 20,),
               Container(
                 width: MediaQuery.of(context).size.width,
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   color: blue,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Column(
                   children: [
                     Text(
                       "Remaining Leaves",
                       style: TextStyle(
                           color: Colors.black,
                           fontFamily: 'sf_pro_bold',
                           fontSize: 18
                       ),
                     ),
                     SizedBox(height: 5,),
                     Text(
                       leaves,
                       style: TextStyle(
                           color: Colors.black,
                           fontFamily: 'sf_pro_semi_bold',
                           fontSize: 18
                       ),
                     )
                   ],
                 ),
               ),

               SizedBox(height: 30,),


               InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                     builder: (context) => EditPassword(userId : widget.userId),
                   ));
                 },
                 child: Container(
                   alignment: Alignment.center,
                   padding: EdgeInsets.all(10),
                   width: MediaQuery.of(context).size.width,
                   color: Colors.red,
                   child : Text(
                       'Change Password',
                       style: TextStyle(
                         color: Colors.white,
                       ),
                   ),
                 ),
               )


             ],
          ),
        ) : Center(child: CircularProgressIndicator()),
      )

    );



  }
}
