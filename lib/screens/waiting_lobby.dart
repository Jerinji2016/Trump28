import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/modals/game.dart';
import 'package:trump28/widget/game_table/game_table.dart';
import 'package:trump28/widget/gradient_background.dart';

class WaitingLobby extends StatefulWidget {
  final Game game;

  const WaitingLobby(this.game, {Key? key}) : super(key: key);

  @override
  _WaitingLobbyState createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GradientBackground(
        child: ChangeNotifierProvider(
          create: (BuildContext context) => widget.game,
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
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
                            vertical: 20.0,
                          ),
                          child: Text(
                            "Waiting for players",
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
                      width: 650.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: GameTable(),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 25.0,
                right: 25.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: _onLeaveTapped,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Leave",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Material(
                      color: Colors.orange[700],
                      borderRadius: BorderRadius.circular(10.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "START",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLeaveTapped() {
    if (widget.game.haveIJoined) {
      //  leave seat
    } else
      Navigator.pop(context);
  }
}
