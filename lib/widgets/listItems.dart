import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItems extends StatefulWidget {
  dynamic color, titleColor, title, icon,onPressed,iconColor,fontSize;

ListItems({ this.color,this.titleColor,this.title,this.icon,this.fontSize = 16.0,this.onPressed,this.iconColor});

  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return       Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        hoverColor: Colors.blueAccent,

        onTap: (){
          widget.onPressed();
        },
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color:widget.color,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.titleColor,
                  fontSize: widget.fontSize,
                ),
              ),
              Icon(
                widget.icon,
                color: widget.iconColor,
              )
            ],
          ),

        ),
      ),
    );
  }
}

