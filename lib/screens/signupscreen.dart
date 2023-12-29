// ignore_for_file: prefer_const_constructors

import 'package:firebase_app/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utilities/utils.dart';
import '../widgets/roundbutton.dart';
import 'homescreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('Signup'),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height*0.07,),
            Column(
              children: [
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                  ),),
                SizedBox(height: height*0.02,),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),),
                SizedBox(height: height*0.02,),
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
                  auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then(
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
                }, title: 'Signup'),
              ],
            ),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already a user?'),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
                }, child: Text('Login!'),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
