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

  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  await SystemChrome.setEnabledSystemUIOverlays([]);

  await Firebase.initializeApp();

  if (preferences == null) preferences = await SharedPreferences.getInstance();

  if (name == null) {
    String? _name = preferences?.getString("name");
    name = (_name == null) ? "Player" : _name;
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.SPLASH,
    ),
  );
}
