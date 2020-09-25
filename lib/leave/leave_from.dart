


import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/color/color.dart';
import 'package:login/database/AuthService.dart';
import 'package:login/widgets/make_input.dart';
import 'package:date_range_picker/date_range_picker.dart'  as DateRagePicker;

class LeaveForm extends StatefulWidget {
  @override
  _LeaveFormState createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  bool submitClicked = false;
  final reasonController  = TextEditingController();
  final dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String fromDate;
  String toDate;
  String countDays;
  String userId;

  String userName;

  initState(){
    super.initState();
    getUid();
  }

  getUid(){
     AuthService.getUserIdSharedPref().then((value) {
       setState(() {
         if(value!=null) userId = value;
       });
     });
     AuthService.getUserNameSharePref().then((value) {
        if(value!=null) {
          setState(() {
            userName = value;
          });

        }
        else{
          Firestore.instance.collection("Users").document(userId).get().then((value) {

              setState(() {
                userName = value.data['name'];
              });

          });
        }

     });
  }


  sendToAdmin(String fromDate, String toDate, String countDays) async{
     await Firestore.instance.collection("LeaveRequests").document().setData({

         "temStamp" : Timestamp.now(),
         "userId" : userId,
         "userName" : userName,
         "fromDate" : fromDate,
         "toDate" : toDate,
          "countDays" : countDays,
         "status"  : "Pending",
         "reason" : reasonController.text,
     }).catchError((e){
       setState(() {
         submitClicked = false;
         return;
       });
     });

     setState(() {
       submitClicked = false;
       reasonController.text = "";
       dateController.text = "";
     });

     Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
         title:Text("Leave Form"),
       ),

       body: Container(
         child: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Column(
             children: [
               Form(
                 key: _formKey,
                 child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 8.0,),
                            Text("Reason Form Leave",style: TextStyle(
                                fontSize: 16.0,color: Colors.black87
                            ),),
                            SizedBox(height: 8.0,),
                            TextFormField(
                              minLines: 10,
                              maxLines: 50,
                              validator: (value){
                                if(value.isEmpty){
                                  return "Field should not be empty";
                                }
                                return null;
                              },
                              controller: reasonController,
                              style: TextStyle(
                                  fontSize: 19.0
                              ),

                              decoration: InputDecoration(

                                contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black45),),
                                border: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderSide: BorderSide(color: Colors.black45),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0,),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: "From data - to Date"
                          ),
                          validator : (value) {
                            if(value.isEmpty) return "Field should not be empty";
                            return null;
                          },
                          onTap: ()async{
                            final List<DateTime> picked = await DateRagePicker.showDatePicker(
                               context : context,
                                initialFirstDate: new DateTime.now(),
                                initialLastDate: (new DateTime.now()).add(new Duration(days: 1)),
                                firstDate: new DateTime(2020),
                                lastDate: new DateTime(2050)
                            );

                           if(picked.isNotEmpty && picked != null)
                            setState(() {
                              fromDate = picked[0].day.toString() + "/"  + picked[0].month.toString() + "/" + picked[0].year.toString();
                              toDate = picked[1].day.toString() + "/"  + picked[1].month.toString() + "/" + picked[1].year.toString();
                              countDays = picked[1].difference(picked[0]).inDays.toString();
                              dateController.text = fromDate + " to " + toDate;
                            });

                          },
                        ),
                      ),


                    ],
                 ),
               ),
               submitClicked == false ?  RaisedButton(
                 onPressed: (){



                     if(_formKey.currentState.validate()) {
                       sendToAdmin(fromDate,toDate,countDays);
                       setState(() {
                         submitClicked = true;
                       });
                     }
                     else{
                       setState(() {
                          submitClicked = false;
                       });
                     }

//                   if(_formKey.currentState.validate()){
//                     setState(() {
//                       submitClicked = true;
//                     });
////                          sendToAdmin(fromDate,toDate,countDays);
//                   }
                   print("clicked");
                 },
                 color: yellow,
                 child: Text(
                   "SUBMIT",
                   style: TextStyle(
                       fontSize: 18
                   ),
                 ),
               )   :  CircularProgressIndicator()
             ],
           ),
         )
       ),
    );
  }
}
