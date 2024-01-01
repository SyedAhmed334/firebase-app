// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:firebase_app/providers/data_provider.dart';
import 'package:firebase_app/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => DataProvider(),),
    ],
    child: MyApp(),),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();

}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        appBarTheme: AppBarTheme(color: Colors.amber),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

