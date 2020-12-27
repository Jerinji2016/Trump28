import 'package:flutter/material.dart';
import 'package:trump28/helper/constants.dart';
import 'package:trump28/modals/game.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> with TickerProviderStateMixin {
  AnimationController _inController, _outController;
  Animation<double> _scaleIn, _opacityIn, _scaleOut, _opacityOut;

  @override
  void initState() {
    game = new Game();
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
      onWillPop: () => _outController.forward(from: 0.0).whenComplete(() {
        lobbyState.value = LobbyState.START;
        return Future.value(false);
      }),
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
          child: Container(
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
                        ..whenComplete(
                            () => lobbyState.value = LobbyState.START),
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
                    "Create Game",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                              onTap: () => createGame(FOUR_PLAYERS),
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
                              onTap: () => createGame(SIX_PLAYERS),
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
        ),
      ),
    );
  }

  createGame(int noOfPlayers) {
    game.noOfPlayers = noOfPlayers;
    id = Game.generateId();
    isHost = true;
    
    game.createSeatingForPlayers();

    _outController.forward(from: 0.0)
      ..whenComplete(
        () => lobbyState.value = LobbyState.WAITING,
      );
  }
}
