import 'package:flutter/material.dart';
import 'package:trump28/main.dart';
import 'package:trump28/res/trump28.dart';
import 'package:trump28/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              background,
              primary,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Center(
                  //  TODO : Add animation to logo text via perspective
                  //  https://medium.com/flutter/perspective-on-flutter-6f832f4d912e
                  child: Trump28(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.white, width: 3.0),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () => Navigator.pushNamed(context, Routes.PLAYER_SELECT),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.green[800]?.withOpacity(0.7),
                          child: Container(
                            height: 120.0,
                            width: 150.0,
                            alignment: Alignment.center,
                            child: Text(
                              "Create\nGame",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.white, width: 3.0),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () => Navigator.pushNamed(context, Routes.JOIN_GAME),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.deepOrange[800]?.withOpacity(0.7),
                          child: Container(
                            height: 120.0,
                            width: 150.0,
                            alignment: Alignment.center,
                            child: Text(
                              "Join\nGame",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
