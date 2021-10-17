import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trump28/modals/njan.dart';
import 'package:trump28/utils/firestore.dart';

import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    User? user = FirebaseAuth.instance.currentUser;

    if(user == null) {
      Future.delayed(Duration(seconds: 1)).then(
        (val) => Navigator.pushReplacementNamed(context, Routes.LOGIN),
      );
      return;
    }

    DocumentSnapshot userSnap = await Firestore.getUser(user.uid);
    Map? userMap = userSnap.data() != null ? userSnap.data() as Map : null;
    if (userMap == null) {
      Future.delayed(Duration(seconds: 1)).then(
            (val) => Navigator.pushReplacementNamed(context, Routes.LOGIN),
      );
      return;
    }
    else
      Njan.initialize(userMap..putIfAbsent("id", () => user.uid));

    Future.delayed(Duration(seconds: 1)).then(
          (val) => Navigator.pushReplacementNamed(context, Routes.HOME),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            "Trump 28",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
