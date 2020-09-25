import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/database/AuthService.dart';
import 'package:login/leave/leave_from.dart';
import 'package:login/sideNavBar/sideNavBar.dart';
import 'package:login/widgets/listItems.dart';
import 'package:pie_chart/pie_chart.dart';

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {

  Map<String, double> dataMap = {
    "TotalLeave": 10,
    "RemainingDay": 5,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  String userId;
  getUserId() async{
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
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(

                padding: EdgeInsets.symmetric(vertical: 30),
                  child: PieChart(
                      dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    //chartLegendSpacing: 50,
                    chartRadius: MediaQuery.of(context).size.width / 2,
                   // colorList: ,
                    initialAngleInDegree: 0,
                    chartType: ChartType.disc,
                    ringStrokeWidth: 32,
                    //centerText: "HYBRID",
                    legendOptions: LegendOptions(

                      showLegendsInRow: false,
                     // legendPosition: LegendPosition.right,
                      showLegends: true,
                      //legendShape: _BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: false,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                    ),
                  ),
              ),
              SizedBox(height: 10,),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                     builder: (context) => LeaveForm()
                  ));
                },
                child: Container(
                 margin: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(
                    "Apply for leave",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),
              // recently added container
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Requests",
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

              // task assigned


              StreamBuilder(
                stream: Firestore.instance.collection("LeaveRequests").
                orderBy("temStamp",descending: true).where("userId",isEqualTo: userId)
                  .snapshots(),
                builder: (context, snapshot){

                  return snapshot.hasData ?  Column(
                    children: List.generate(snapshot.data.documents.length, (index) {

                      DocumentSnapshot doc = snapshot.data.documents[index];
                      return Column(
                        children: [
                          ListItems(
                              color: Colors.green,
                              title: "${(doc['reason']).toString()}  (  ${ doc['status']} )" ,
                              titleColor: Colors.white,
                              onPressed: (){

                              },
                            ),
                            SizedBox(height: 10,)

                        ],
                      );

                    }),
                  ) : Container();
                }

              )


            ],
          ),
        ),
      ),


    );
  }
}
