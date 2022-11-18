import 'package:chattey/Screens/chatScreen.dart';
import 'package:chattey/Screens/goinus.dart';
import 'package:chattey/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


  
   
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loginScreen() ,
      debugShowCheckedModeBanner: false,
      routes: {
        "chatpage":(context) => ChatBage(),
      },
    );
      
  }
}