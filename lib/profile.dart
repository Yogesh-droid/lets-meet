
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'CameraPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Profile extends StatefulWidget {
  final String url;

  const Profile({Key key, this.url}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseReference mRef=FirebaseDatabase.instance.reference().child('imgURL');
  List<String>list=[];
  @override
  Widget build(BuildContext context) {
    final Color color1 = Color(0xffFC5CF0);
    final Color color2 = Color(0xffFE8852);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [color1, color2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Text(
                  "lets meet",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                            child:ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                              child: StreamBuilder(
                                  stream:mRef.onValue,
                                  builder: (context,AsyncSnapshot <Event> snapshot){
                                        DataSnapshot dataSnapshot=snapshot.data.snapshot;
                                        Map<dynamic, dynamic> values = dataSnapshot.value;
                                        values.forEach((key, values) {
                                          list.add(values);
                                        });
                                        return Image.network(list[0]);
                                  },),
                      ),
                      )],
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "xyz",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                    Text(
                      "Lucknow, Uttar Pradesh, India",
                      style: TextStyle(color: Colors.grey.shade600),
                    )
                  ],
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: Colors.grey,
                      icon: Icon(FontAwesomeIcons.instagram),
                      onPressed: () {},
                    ),
                    IconButton(
                      color: Colors.grey,
                      icon: Icon(FontAwesomeIcons.facebookF),
                      onPressed: () {},
                    ),
                    IconButton(
                      color: Colors.grey.shade600,
                      icon: Icon(FontAwesomeIcons.twitter),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
               /* Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 16.0),
                        margin: const EdgeInsets.only(
                            top: 30, left: 20.0, right: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color1, color2],
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                         child: Row(
                          children: <Widget>[
                            IconButton(
                              color: Colors.white,
                              icon: Icon(FontAwesomeIcons.user),
                              onPressed: (){},
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.location_on),
                              onPressed: (){},
                            ),
                            Spacer(),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.add),
                              onPressed: (){},
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.message),
                              onPressed: (){},
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: FloatingActionButton(
                          heroTag: 'one',
                          child: Icon(Icons.favorite, color: Colors.pink,),
                          backgroundColor: Colors.white,
                          onPressed: (){
                            print('FAB pressed');
                          },
                        ),
                      ),
                    ],
                  ),
                )*/
              ],
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OpenCamera()));
                },
              ),
              IconButton(
                icon: Icon(Icons.menu),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
