import 'package:notes_app/auth_gate.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform
      // options: const FirebaseOptions(
      //   apiKey: 'apikey',
      //   appId: 'appId',
      //   messagingSenderId: 'messagingSenderId',
      //   projectId: 'analogy-notes',
      //   storageBucket: 'storageBucket',
      // ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analogy Notes',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF989898)),
          useMaterial3: true,
          primaryColor: Color(0xFF989898)),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
