import 'package:flutter/material.dart';
import 'package:lets_meet_demo1/customBottom.dart';

void main(){
  runApp(MainPage());
}
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MyApp()
    );
  }
}
