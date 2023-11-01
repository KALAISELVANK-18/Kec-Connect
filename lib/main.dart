import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kecconnect/Contact.dart';
import 'package:kecconnect/HomePage.dart';
import 'package:kecconnect/MyHomePage1.dart';
import 'package:kecconnect/collapse.dart';

import 'firebase_options.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();



  // Get a specific camera from the list of available cameras.

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {



      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,

      ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

