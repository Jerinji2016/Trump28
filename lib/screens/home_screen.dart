import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trump28/main.dart';
import 'package:trump28/modals/njan.dart';
import 'package:trump28/res/trump28.dart';
import 'package:trump28/routes.dart';
import 'package:trump28/utils/firestore.dart';
import 'package:trump28/widget/gradient_background.dart';
import 'package:trump28/widget/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Njan njan = Njan();

  @override
  Widget build(BuildContext context) {
  Offset _offset = Offset(0, 0);
    return Scaffold(
      body: GradientBackground(
        colors: [
          background,
          primary,
        ],
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Toast.show(context, "Welcome to Trump28\nNice to meet you!", Toast.LENGTH_LONG);
                    },
                    child: Center(
                      child: Trump28(),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: _logOut,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                "Log out",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChangeNotifierProvider(
                            create: (BuildContext context) => njan,
                            child: Text(
                              njan.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50.0),
                              onTap: _changeName,
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
                  Container(
                    child: Text(
                      "ID: ${njan.id}",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
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

  void _changeName() async {
    TextEditingController _nameController = new TextEditingController();

    final UnderlineInputBorder _whiteBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 2.0,
      ),
    );

    String? newName = await showDialog(
      context: context,
      builder: (context) => Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.35,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        focusedBorder: _whiteBorder,
                        enabledBorder: _whiteBorder,
                        labelText: njan.name,
                        labelStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 18,
                        ),
                        alignLabelWithHint: true,
                      ),
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _iconButton(
                          Icons.close,
                          () => Navigator.pop(context, null),
                          Colors.red,
                        ),
                        SizedBox(width: 20.0),
                        _iconButton(
                          Icons.done,
                          () {
                            String newName = _nameController.text.trim();
                            Navigator.pop(context, newName);
                          },
                          Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (newName == null || newName == njan.name) return;

    await Firestore.updateName(newName);
    njan.name = newName;
    njan.notify();
  }

  Widget _iconButton(IconData icon, void Function() onTap, Color highlightColor) => Material(
        color: Colors.transparent,
        shape: CircleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.white,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100.0),
          highlightColor: highlightColor,
          splashColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      );

  void _logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, Routes.LOGIN);
  }
}
