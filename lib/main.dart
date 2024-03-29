import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trump28/globals.dart';

import 'routes.dart';

const Color background = Color(0xFF420516);
const Color primary = Color(0xFF7D1935);
const Color secondary = Color(0xFFB42B51);
const Color accent = Color(0xFFE63E6D);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  preferences = await SharedPreferences.getInstance();

  //  TODO: Remove in production
  await _initEmulators();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.SPLASH,
    ),
  );
}

/// Initialize emulator
/// TODO: Remove in production
Future<void> _initEmulators() async {
  var ip = "192.168.1.7";
  print("initialising emulator configs... $ip");
  //  Authentication emulator
  await FirebaseAuth.instance.useAuthEmulator(ip, 9099);

  //  Firestore emulator
  FirebaseFirestore.instance.useFirestoreEmulator(ip, 8080);

  //  Cloud functions emulator
  FirebaseFunctions.instance.useFunctionsEmulator(ip, 5001);
}
