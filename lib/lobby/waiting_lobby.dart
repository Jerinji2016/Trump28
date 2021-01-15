import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trump28/game/res/table_bg.dart';
import 'package:trump28/helper/codes.dart';
import 'package:trump28/helper/constants.dart';
import 'package:trump28/helper/udp.dart';
import 'package:trump28/modals/player.dart';

enum From { JOIN, CREATE }

class WaitingLobby extends StatefulWidget {
  final From from;
  WaitingLobby(this.from);

  @override
  _WaitingLobbyState createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby>
    with TickerProviderStateMixin {
  AnimationController _inController, _outController;
  Animation<double> _scaleIn, _opacityIn, _scaleOut, _opacityOut;

  bool _playersIsLoading = false;
  bool _isPlayerTeamedUp = false;

  @override
  void initState() {
    _inController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _outController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _scaleIn = new Tween<double>(
      begin: .75,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _inController,
      ),
    );
    _opacityIn = new Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _inController,
      ),
    );
    _scaleOut = new Tween<double>(
      begin: 1,
      end: 1.3,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _outController,
      ),
    );
    _opacityOut = new Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _outController,
      ),
    );

    _inController.forward(from: 0.0);
    super.initState();
    initialise();
  }

  initialise() async {
    if (isHost) {
      udp = new UDP(HOST_IP);
      await udp.connect();
      udp.onDataHandler(hostOnDataHandler);
    }
  }

  @override
  void dispose() {
    _inController?.dispose();
    _outController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        lobbyState.value =
            (widget.from == From.JOIN) ? LobbyState.JOIN : LobbyState.CREATE;
        return Future.value(false);
      },
      child: AnimatedBuilder(
        animation: _outController,
        builder: (_, __) => Opacity(
          opacity: _opacityOut.value,
          child: Transform.scale(
            scale: _scaleOut.value,
            child: __,
          ),
        ),
        child: AnimatedBuilder(
          animation: _inController,
          builder: (_, __) => Opacity(
            opacity: _opacityIn.value,
            child: Transform.scale(
              scale: _scaleIn.value,
              child: __,
            ),
          ),
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50.0),
                        child: InkWell(
                          splashColor: Colors.black38,
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () => _outController.forward(from: 0.0)
                            ..whenComplete(() => lobbyState.value =
                                (widget.from == From.JOIN)
                                    ? LobbyState.JOIN
                                    : LobbyState.CREATE),
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
                    Container(
                      child: Text(
                        "Waiting for Players",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        width: 500.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: _playersIsLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                            : Container(
                                child: Stack(
                                  children: [
                                    TableBackground(),
                                    joinableSeats(),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 25.0,
                right: 25.0,
                child: Material(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: startGame,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget joinableSeats() {
    List<Widget> seats = [];

    seats.addAll([
      new Positioned(
        child: Container(
          margin: EdgeInsets.only(top: 10.0),
          alignment: Alignment.topCenter,
          child:
              game.noOfPlayers == FOUR_PLAYERS ? seat(3, true) : seat(4, false),
        ),
      ),
      new Positioned(
        child: Container(
          margin: EdgeInsets.only(bottom: 5.0),
          alignment: Alignment.bottomCenter,
          child: seat(1, true),
        ),
      ),
    ]);

    if (game.noOfPlayers == FOUR_PLAYERS)
      seats.addAll([
        new Positioned(
          child: Container(
            alignment: Alignment.centerLeft,
            child: seat(2, false),
          ),
        ),
        new Positioned(
          child: Container(
              alignment: Alignment.centerRight, child: seat(4, false)),
        ),
      ]);
    else
      seats.addAll([
        new Positioned(
          top: 40.0,
          left: 40.0,
          child: Container(
            child: seat(3, true),
          ),
        ),
        new Positioned(
          top: 40.0,
          right: 40.0,
          child: Container(
            child: seat(5, true),
          ),
        ),
        new Positioned(
          bottom: 40.0,
          left: 40.0,
          child: Container(
            child: seat(2, false),
          ),
        ),
        new Positioned(
          bottom: 40.0,
          right: 40.0,
          child: Container(
            child: seat(6, false),
          ),
        ),
      ]);

    return Stack(children: seats);
  }

  Widget seat(int seatNo, bool team) => (game.players[seatNo] == null)
      ? Material(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            onTap: () => _isPlayerTeamedUp
                ? swapSeat(seatNo, team)
                : selectSeat(seatNo, team),
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                _isPlayerTeamedUp ? Icons.swap_horiz_sharp : Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        )
      : Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Text(
                  game.players[seatNo].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Text(
                  game.players[seatNo].id,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        );

  selectSeat(int seatNo, bool team) {
    if (isHost) {
      game.players[seatNo] = Player(id, name.value, team: team);
      _isPlayerTeamedUp = true;
      setState(() {});
    } else {
      //  Request host for seat
    }
  }

  swapSeat(int seatNo, bool team) {
    if (isHost) {
      int currentSeat = game.getPlayerSeat(id);
      print("Current Seat $currentSeat");
      if (currentSeat > 0) {
        game.players[currentSeat] = null;
        game.players[seatNo] = Player(id, name.value, team: team);
      }
      setState(() {});
    } else {
      //  Request host to swap seat
    }
  }

  hostOnDataHandler(String data) {
    List<String> message = decode(data);
    int code = int.parse(message[0]);

    switch (code) {
      case REQUEST_CONN:
        String response = encode([ACCEPT_CONN.toString(), name.value]);
        udp.sendData(response, message[1]);
        break;
    }
  }

  startGame() {
    //  Check for all players
  }
}
