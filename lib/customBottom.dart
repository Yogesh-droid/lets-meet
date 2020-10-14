import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_meet_demo1/profile.dart';
import 'package:lets_meet_demo1/profile_details.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: Icon(
          Icons.location_on,
          color: Colors.red,
        ),
        actions: [
          Icon(
            Icons.chat_bubble,
            color: Colors.red,
          ),
          SizedBox(
            width: 20.0,
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Lets@Meet',
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
      body: ExampleHomePage(),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.transparent,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.white,
        height: 70.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30.0,
            color: Colors.redAccent,
          ),
          /* Icon(
                Icons.chat_bubble,
                size: 30.0,
                color: Colors.redAccent,
              ),*/
          Icon(
            FontAwesomeIcons.heart,
            size: 30.0,
            color: Colors.redAccent,
          ),
          /*Icon(
                Icons.location_on,
                size: 30.0,
                color: Colors.redAccent,
              ),*/
          IconButton(
            icon: Icon(
              Icons.person_pin,
              size: 30.0,
              color: Colors.redAccent,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
        ],
      ),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  final Color color1 = Color(0xffFC5CF0);
  final Color color2 = Color(0xffFE8852);
  List<String> welcomeImages = [
    "images/img1.jpg",
    "images/img2.jpg",
    "images/img4.jpg",
    "images/img3.jpg",
    "images/img5.jpg",
    "images/img6.jpg",
    "images/img6.jpg",
    "images/img6.jpg",
  ];
  List<String> names = [
    'Nisha',
    'Julia',
    'Jenny',
    'Poorna',
    'Kavita',
    'Bidisha'
  ];
  List<int> ages = [21, 22, 23, 24, 25, 26];
  List<String> addresses = [
    'Gurgaon',
    'Jind',
    'Bhiwani',
    'Delhi',
    'Rohtak',
    'Rewari'
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.red,
        end: Colors.green,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.green,
        end: Colors.blue,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue,
        end: Colors.pink,
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.
    return Container(
      color:background
          .evaluate(AlwaysStoppedAnimation(_controller.value)) ,
        /*decoration: BoxDecoration(
            //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
            gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),*/
        child: Container(
            // height: MediaQuery.of(context).size.height * .8,
            height: MediaQuery.of(context).size.height * .8,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 100.0),
            child: TinderSwapCard(
              orientation: AmassOrientation.BOTTOM,
              totalNum: 8,
              //stackNum: 6,
              //swipeEdge: 10.0,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              //maxHeight: MediaQuery.of(context).size.width * 0.9,
              maxHeight: 700,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: MediaQuery.of(context).size.width * 0.8,
              //minHeight: 400,
              cardBuilder: (context, index) => Card(
                child: new Stack(
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        '${welcomeImages[index]}',
                        fit: BoxFit.fill,
                        height: 700,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                    ),
                    Positioned(
                      top: 500,
                      child: new Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: 200,
                          decoration: new BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(180)
                              ])),
                          child: Text('')),
                    ),
                  ],
                ),
              ),
              cardController: controller = CardController(),
              swipeUpdateCallback:
                  (DragUpdateDetails details, Alignment align) {
                if (align.x < 0) {
                } else if (align.x > 0) {}
              },
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) {},
            )));
  }
}
