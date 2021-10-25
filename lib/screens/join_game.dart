import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trump28/globals.dart';
import 'package:trump28/modals/game.dart';
import 'package:trump28/res/font_map/suits_icons.dart';
import 'package:trump28/routes.dart';
import 'package:trump28/utils/firestore.dart';
import 'package:trump28/widget/toast.dart';

import '../main.dart';

class JoinGame extends StatefulWidget {
  const JoinGame({Key? key}) : super(key: key);

  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  TextEditingController _roomIdController = TextEditingController(text:"2XR934RQ");

  final InputBorder _inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
    color: Colors.white,
    width: 2,
  ));

  @override
  void dispose() {
    super.dispose();
    _roomIdController.dispose();
  }

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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                Suits.spades,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                Suits.hearts,
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                Suits.clubs,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                Suits.dice,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 200.0,
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: TextField(
                            controller: _roomIdController,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 10,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 3.0
                            ),
                            decoration: InputDecoration(
                              border: _inputBorder,
                              enabledBorder: _inputBorder,
                              focusedBorder: _inputBorder,
                              hintText: "Enter Lobby ID",
                              counterText: "",
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        child: Material(
                          color: Colors.green[700],
                          elevation: 15.0,
                          borderRadius: BorderRadius.circular(10.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: _joinRoom,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              child: Text(
                                "Join Room",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _joinRoom() async {
    String roomId = _roomIdController.text.trim();

    // if(roomId == Njan().roomID){
    //   Toast.show(context, "Can't join to that room!", Toast.LENGTH_SHORT);
    //   return;
    // }

    var response = await Firestore.getRoomDetails(roomId);
    if(response == null) {
      Toast.show(context, "Invalid room", Toast.LENGTH_SHORT);
      return;
    }

    if(response is bool && !response) {
      Toast.show(context, "Room expired. Ask host to create room again", Toast.LENGTH_LONG);
      return;
    }

    var game = Game.create(response);
    Navigator.pushNamed(
      context,
      Routes.GAME_MANAGER,
      arguments: game,
    );
  }
}
