import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/database/AuthService.dart';


class EditProfile extends StatefulWidget {

  final dynamic profilePic,
   name, userId, address, phone,
   password;

  EditProfile({this.profilePic,this.name,this.userId,this.phone,this.address,this.password});

  @override
  _EditProfileState createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfile> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  initState(){
    super.initState();
    setState(() {
      addressController.text  = widget.address;
      phoneNumber.text = widget.phone;
    });
  }

  File imageFile;

  bool clicked = false;


  Widget submitBtn() {
    if(clicked ==  false) {
      return MaterialButton(
        minWidth: double.infinity,
        color: Colors.blue,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () async{

          if(!_formKey.currentState.validate()) {

          }
          else {
            setState(() {
              clicked = true;
            });

            if (imageFile!=null) {
              StorageUploadTask uploadThumbnailImage = FirebaseStorage.instance.ref().
              child(widget.userId).child("ProfilePic").putFile(imageFile);

              final StorageTaskSnapshot imageDownloadUrl =
              (await uploadThumbnailImage.onComplete);
              final String imageUrl = await imageDownloadUrl.ref.getDownloadURL();

             await  Firestore.instance.collection("Users").document(widget.userId).updateData({
                 "profilePic" : imageUrl,
                 "address" : addressController.text,
                 "phone" : phoneNumber.text,
              });

            }


            Navigator.pop(context);

          }
        },
        height: 50.0,
        child: Text("UPDATE", style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          fontFamily: 'sf_pro_bold',
        ),),
      );
    }
    return CircularProgressIndicator();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Edit Profile"),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: ()async{
                  File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    imageFile  = File(image.path);
                  });
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:imageFile != null ? FileImage(imageFile) :  widget.profilePic!= null ?
                  NetworkImage(widget.profilePic) : AssetImage('assets/images/add_image.png'),
                ),
              ),


              SizedBox(height: 20,),

              TextFormField(
                validator: (value){
                  if(value.isEmpty) {
                    return "Field should not be empty";
                  }
                  return null;
                },
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Edit Address",
                ),
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value.isEmpty) {
                    return "Field should not be empty";
                  }
                  if(value.length<10 || value.length>10) {
                    return "Invalid Phone Number";
                  }
                  return null;
                },
                controller: phoneNumber,
                decoration: InputDecoration(
                  labelText: "Edit Phone Number",


                ),
              ),





              SizedBox(height: 30,),

              submitBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
