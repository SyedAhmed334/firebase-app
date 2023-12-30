// ignore_for_file: prefer_const_constructors

import 'package:firebase_app/screens/homescreen.dart';
import 'package:firebase_app/screens/loginscreen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SplashServices{


final auth = FirebaseAuth.instance;
void isLogin(BuildContext context){
  if(auth.currentUser != null){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
  }else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
  }
}
}
