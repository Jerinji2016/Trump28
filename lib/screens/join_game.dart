import 'package:flutter/material.dart';
import 'package:trump28/globals.dart';

import '../main.dart';

class JoinGame extends StatefulWidget {
  const JoinGame({Key? key}) : super(key: key);

  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  final InputBorder _inputBorder =  UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      )
  );

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
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50.0),
                    child: InkWell(
                      splashColor: Colors.black38,
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.arrow_back_outlined,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Center(
                  child: Hero(
                    tag: TITLE_BAR,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: Text(
                        "Join Game",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 200.0,
                      ),
                      child: Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: _inputBorder,
                            enabledBorder:  _inputBorder,
                            focusedBorder:  _inputBorder,
                            hintText: "Enter Lobby ID",
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                            )
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
