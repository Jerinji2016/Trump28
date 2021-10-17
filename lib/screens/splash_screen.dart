import 'package:flutter/material.dart';
import 'package:trump28/globals.dart';

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
    String? _id = preferences.getString("id");

    if(_id == null) {
      Future.delayed(Duration(seconds: 1)).then(
        (val) => Navigator.pushReplacementNamed(context, Routes.LOGIN),
      );
      return;
    }

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
