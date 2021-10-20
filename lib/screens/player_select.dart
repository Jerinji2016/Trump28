import 'package:flutter/material.dart';
import 'package:trump28/modals/game.dart';
import 'package:trump28/routes.dart';
import 'package:trump28/utils/trump_api.dart';

import '../main.dart';

class PlayerSelect extends StatefulWidget {
  const PlayerSelect({Key? key}) : super(key: key);

  @override
  _PlayerSelectState createState() => _PlayerSelectState();
}

class _PlayerSelectState extends State<PlayerSelect> {
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
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 30.0,
                    ),
                    child: Text(
                      "Create Game",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
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
                          onTap: () => _createGame(GameType.FourPlayer),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.blueGrey[800],
                          child: Container(
                            height: 120.0,
                            width: 150.0,
                            alignment: Alignment.center,
                            child: Text(
                              "4\nPlayers",
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
                          onTap: () => _createGame(GameType.SixPlayer),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.blueGrey[800],
                          child: Container(
                            height: 120.0,
                            width: 150.0,
                            alignment: Alignment.center,
                            child: Text(
                              "6\nPlayers",
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

  void _createGame(GameType gameType) async {
    var game = await TrumpApi.initializeRoom(gameType);

    Navigator.pushNamed(
      context,
      Routes.WAITING_LOBBY,
      arguments: game,
    );
  }
}
