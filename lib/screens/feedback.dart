import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:login/color/color.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

enum feedback { One , Two , Three , Four , Five  }

class _FeedBackState extends State<FeedBack> {

  feedback _character = feedback.One;

  final formKey = GlobalKey<FormState>();
  TextEditingController candidateName = new TextEditingController();
  TextEditingController interviewerName = new TextEditingController();
  TextEditingController commentBox = new TextEditingController();


  dynamic _value1 = 1;

  String getValue() {
     if(_value1 ==  1) {
       return "Fresher/Intern";
     }
     else if(_value1 == 2) {
       return "H.R Manager";
     }
     else if(_value1 == 3) {
       return "Director";
     }
     else{
       return "CEO";
     }
  }

  String feedBackSelected() {
     if(_character.toString() == "feedback.One") {
       return "1";
     }
     else if(_character.toString() == "feedback.Two"){
       return "2";
     }
     else if(_character.toString() == "feedback.Three") {
       return "3";
     }
     else if(_character.toString() == "feedback.Four"){
       return "4";
     }
     else{
       return "5";
     }
  }


  bool clicked = false;


  saveToFirebase()async{

     await Firestore.instance.collection("Feedback").document().setData({
           "timeStamp" : Timestamp.now(),
           "Interviewer Name" : interviewerName.text,
           "Candidate Name" : candidateName.text,
           "comment" : commentBox.text,
           "Role" : getValue(),
           "Rating" : feedBackSelected(),
     }).catchError((e){
       setState(() {
         clicked = false;
         print(e);
       });
     }) ;

     Navigator.pop(context);


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 15,),
                Text(
                  "Feedback form",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "sf_pro_bold",
                      fontSize: 17
                  ),
                ),
                SizedBox(height: 25,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  TextFormField(
                    controller: interviewerName,
                    validator: (val) {
                      return val.isEmpty ? "this is a not valid password" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "interviewer's name",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        )
                    ),
                  ),
                ),


                SizedBox(height: 25,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  TextFormField(
                    controller: candidateName,
                    validator: (val) {
                      return val.isEmpty ? "this is a not valid password" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Candidates'name",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        )
                    ),
                  ),
                ),

                //  container for role of interview
                SizedBox(height: 20,),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:  Container(
                      padding: EdgeInsets.all(2),
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButton(
                          value: _value1,
                          items: [
                            DropdownMenuItem(
                              child: Text("Role interview for fresher/intern"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("H.R Manager"),
                              value: 2,
                            ),
                            DropdownMenuItem(
                                child: Text("Director"),
                                value: 3
                            ),
                            DropdownMenuItem(
                                child: Text("CEO"),
                                value: 4
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value1 = value;
                            });
                          }),
                    )
                ),

                //   container for stage of interview

                SizedBox(height: 20,),

//                Container(
//                    margin: EdgeInsets.symmetric(horizontal: 20),
//                    padding: EdgeInsets.symmetric(horizontal: 20),
//                    decoration: BoxDecoration(
//                        border: Border.all(color: Colors.black),
//                        borderRadius: BorderRadius.circular(10)
//                    ),
//                    child:  Container(
//
//                      padding: EdgeInsets.all(2),
//                      width: MediaQuery.of(context).size.width,
//                      child: DropdownButton(
//                          value: _value2,
//                          items: [
//                            DropdownMenuItem(
//                              child: Text(""),
//                              value: 1,
//                            ),
//                            DropdownMenuItem(
//                              child: Text("Second Item"),
//                              value: 2,
//                            ),
//                            DropdownMenuItem(
//                                child: Text("Third Item"),
//                                value: 3
//                            ),
//                            DropdownMenuItem(
//                                child: Text("Fourth Item"),
//                                value: 4
//                            )
//                          ],
//                          onChanged: (value) {
//                            setState(() {
//                              _value2 = value;
//                            });
//                          }),
//                    )
//                ),


                //  container for choose checkbox
                SizedBox(height: 30,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "KEY: A candidate should be rated on a scale from 1 to 5",
                    style: TextStyle(fontFamily: "sf_pro_medium" , fontSize: 15),
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "5. Exceeds requirement",
                          ),
                          SizedBox(width: 20,),
                          Text(
                              "4. Above average"
                          )
                        ],
                      ),

                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "3. Average",
                          ),

                          SizedBox(width: 100,),
                          Text(
                              "2. below Average"
                          )
                        ],
                      ),

                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "1. Fair below average",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 25,),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child:   Column(
                    children: <Widget>[
                      ListTile(
                        title:  Text('Far below average' , style: TextStyle(
                            fontFamily: "sf_pro_medium",
                            fontSize: 15
                        ),),
                        leading: Radio(
                          value: feedback.One,
                          groupValue: _character,
                          onChanged: (feedback value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),


                      ListTile(
                        title: Text('below average'),
                        leading: Radio(
                          value: feedback.Two,
                          groupValue: _character,
                          onChanged: (feedback value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),

                      ListTile(
                        title: Text('Average'),
                        leading: Radio(
                          value: feedback.Three,
                          groupValue: _character,
                          onChanged: (feedback value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),


                      ListTile(
                        title: Text('Above Average'),
                        leading: Radio(
                          value: feedback.Four,
                          groupValue: _character,
                          onChanged: (feedback value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),


                      ListTile(
                        title: Text('Exceeds requirements'),
                        leading: Radio(
                          value: feedback.Five,
                          groupValue: _character,
                          onChanged: (feedback value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),


                SizedBox(height: 25,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  TextFormField(
                    controller: commentBox,
                    validator: (val) {
                      return val.isEmpty ? "field should not be empty" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Comments",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        )
                    ),
                  ),
                ),

                // submit button

                SizedBox(height: 40,),

                clicked == false ?  InkWell(
                  onTap: (){
                      if(formKey.currentState.validate()){
                        setState(() {
                           clicked = true;
                        });

                        saveToFirebase();

                      }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: yellow,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontFamily: "sf_pro_medium",
                            fontSize: 20,
                            color: Colors.black
                        ),
                      )
                  ),
                ) : CircularProgressIndicator(),

                SizedBox(height: 30,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}









