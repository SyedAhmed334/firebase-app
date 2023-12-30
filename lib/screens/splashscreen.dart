// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:firebase_app/screens/loginscreen.dart';
import 'package:firebase_app/services/splashscreenservices.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),() => SplashServices().isLogin(context));
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
             Center(
               child: Image(
                 width: width,
                 height: height*0.4,
                 image: AssetImage('asset/images/logo.png'),
               ),
             ),
          Text('Firebase App',style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),),

        ],
      ),
    );
  }
}
