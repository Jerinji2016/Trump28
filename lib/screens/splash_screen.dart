import 'package:flutter/material.dart';

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
