import 'package:flutter/material.dart';
import 'package:login/color/color.dart';

class TopCard extends StatelessWidget {

  final dynamic onPressed, title,
      subTitle, btnText, btnColor,
      cardColor,titleColor,subTitleColor,
      btnTextColor,icon;

  TopCard({
    this.title = "Title",
    this.subTitle = "subTitle" ,
    this.btnText ="click",
    this.btnColor = Colors.red,
    this.cardColor = Colors.yellow,
    this.btnTextColor  = Colors.white,
    this.titleColor = Colors.black,
    this.subTitleColor = Colors.black,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: this.cardColor,
            ),

            width:  MediaQuery.of(context).size.width*0.90,

            child : Column(
              children: [

                Container(
                  alignment :  Alignment.centerLeft,
                  child: Text(
                      this.title,
                      style : TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                ),
                Container(
                  alignment :  Alignment.centerLeft,
                  child: Text(
                      this.subTitle,
                      style : TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                ),

                SizedBox(height: 15,),

                this.icon,
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    onPressed: (){
                      onPressed();
                    },
                    color: this.btnColor,
                    child: Text(
                        this.btnText,
                        style : TextStyle(
                          color : white,
                        )
                    ),
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }
}
