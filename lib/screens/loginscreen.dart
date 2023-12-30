// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_app/screens/homescreen.dart';
import 'package:firebase_app/screens/signupscreen.dart';
import 'package:firebase_app/utilities/utils.dart';
import 'package:firebase_app/widgets/roundbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final emailController = TextEditingController();
 final passwordController = TextEditingController();
 final auth = FirebaseAuth.instance;
 bool loading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('Login'),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height*0.13,),
            Column(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                  ),),
                SizedBox(height: height*0.02,),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                  ),),
                SizedBox(
                  height: height*0.05,
                ),
                RoundButton(onTap: (){
                  setState(() {
                    loading = true;
                  });
                  auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then(
                          (value) {
                            setState(() {
                              loading = false;
                            });
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        );
                      }
                  ).onError((error, stackTrace){
                    setState(() {
                      loading = false;
                    });
                            Utils().showToast(error.toString());
                  });

                }, title: 'Login',loading: loading,),
              ],
            ),
            Spacer(),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New here?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),),);
                  }, child: Text('Signup!'),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
