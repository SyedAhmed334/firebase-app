// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/loginscreen.dart';
import 'package:firebase_app/widgets/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  // bool isEnabled = false;
  bool isEditable = false;
  final fireStore = FirebaseFirestore.instance.collection('User Data');
  DocumentSnapshot? userData;
  Future<void> fetchData () async{
    userData = await FirebaseFirestore.instance.collection('User Data').doc(auth.currentUser!.uid.toString()).get();
  }

  void updateControllers(){
    final Map<String, dynamic> map = userData!.data() as Map<String, dynamic>;
    firstNameController.text = map['firstname'];
    lastNameController.text = map['lastname'];
    emailController.text = map['email'];
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((value){
    updateControllers();
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(centerTitle: true,title: Text('${firstNameController.text}\'s Profile'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(onPressed: (){
              auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
            }, icon: Icon(Icons.logout,size: 26,),),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*0.07,),
            Text('First Name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            TextFormField(
              controller: firstNameController,
              enabled: isEditable,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300),),
              ),
              onFieldSubmitted: (val){
                firstNameController.text = val;
              },
            ),
            SizedBox(height: height*0.02,),
            Text('Last Name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            TextFormField(
              controller: lastNameController,
              enabled: isEditable,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300),),
              ),
              onFieldSubmitted: (val){
                lastNameController.text = val;
              },
            ),
            SizedBox(height: height*0.02,),
            Text('Email',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            TextFormField(
              controller: emailController,
              enabled: isEditable,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300),),
              ),
              onFieldSubmitted: (val){
                emailController.text = val;
              },
            ),
            SizedBox(height: height*0.05,),
            isEditable ? Row(mainAxisAlignment: MainAxisAlignment.end,children: [
              ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber),),onPressed: (){
                setState(() {
                  isEditable = false;
                });
                fireStore.doc(auth.currentUser!.uid).set(
                  {
                  'firstname' : firstNameController.text,
                  'lastname' : lastNameController.text,
                  'email' : emailController.text,
                  }
                );
              }, child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.05),
                child: Text('Save',style: TextStyle(color: Colors.black),),
              ),),
              SizedBox(width: width*0.02 ,),
              ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber),),onPressed: (){
                setState(() {
                  isEditable = false;
                  updateControllers();
                });
              }, child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.05),
                child: Text('Cancel',style: TextStyle(color: Colors.black),),
              ),),
            ],) :RoundButton(onTap: (){
              setState(() {
                isEditable = true;
              });
            }, title: 'Edit Profile')
          ],
        ),
      ),
    );
  }
}
