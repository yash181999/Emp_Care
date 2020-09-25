import 'package:flutter/material.dart';

class EditPassword extends StatefulWidget {
  final dynamic userId ;
  EditPassword({this.userId});
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Edit Password'),
      ),

      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Old Password",
                  
                ),
              ),

              SizedBox(height: 10,),

              TextFormField(
                decoration: InputDecoration(
                  labelText: "New Password",

                ),
              ),

              SizedBox(height: 20,),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: MaterialButton(
                  onPressed: (){

                  },

                  color: Colors.blue,

                  child: Text(
                      "SUBMIT",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                  ),



                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
