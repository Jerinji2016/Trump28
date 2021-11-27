import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/providers/game.dart';
import 'package:trump28/utils/trump_api.dart';
import 'package:trump28/widget/toast.dart';

import 'room_bg/player_seats.dart';
import 'room_bg/room_bg.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  _WaitingLobbyState createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late Game game;

  @override
  Widget build(BuildContext context) {
    print('_WaitingLobbyState.build: ');
    game = Provider.of<Game>(context);
    return Stack(
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
                child: Stack(
                  children: [
                    RoomTable(),
                    PlayerSeats(),
                  ],
                ),
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
                  onTap: () => _onLeaveTapped(game),
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
              AnimatedSize(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 200),
                child: (game.haveIJoined)
                    ? Material(
                        color: Colors.orange[700],
                        borderRadius: BorderRadius.circular(10.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: _onReadyTapped,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              (game.me?.isReady ?? false ) ? "CANCEL" : "READY",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _onLeaveTapped(Game game) async {
    if (game.haveIJoined) {
      var response = await TrumpApi.leaveSeat(game.roomId, game.mySeat);
      Toast.show(context, response["status"] ? "Left joined seat" : response["message"], Toast.LENGTH_SHORT);
    } else
      Navigator.pop(context);
  }

  void _onReadyTapped() async {
    var response = await TrumpApi.playerReady(
      game.roomId,
      game.mySeat!,
      !(game.me?.isReady ?? false),
    );
    print(response);
  }
}
