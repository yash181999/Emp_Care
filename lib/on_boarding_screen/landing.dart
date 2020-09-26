

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/database/AuthService.dart';

import '../login.dart';
import 'Slider.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  int _currentPage = 0;
  PageController _controller = PageController();

  initState(){
    super.initState();
    setOnBoardingSeen();
  }

  setOnBoardingSeen() async {
    await AuthService.setOnBoardingSeenToSharedPref().then((value) {
       return value;
    });
  }

  List<Widget> _pages = [
    SliderPage(
        title: "Leave Manager",
        description:
        "Apply for leaves on your fingertips",
        image: "assets/images/leave.png"),
    SliderPage(
        title: "Empbot",
        description: "Get smart solutions from the AI Chabot",
        image:"assets/images/chat_bot.png"),
    SliderPage(
        title: "E-Conference",
        description:
        "Stay connected with your colleagues",
        image: "assets/images/video_call.png"),
    SliderPage(
        title: "Discussion",
        description:
        "Discuss your queries with your collegues in our discussion forum",
        image: 'assets/images/discussion.png',
    )

  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? Colors.blue
                                : Colors.blue.withOpacity(0.5)));
                  })),
              InkWell(
                onTap: () {
                  _controller.nextPage(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOutQuint);
                },
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                  },
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 300),
                    height: 70,
                    width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(35)),
                    child: (_currentPage == (_pages.length - 1))
                        ? Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                        : Icon(
                      Icons.navigate_next,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}
