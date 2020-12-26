import 'package:flutter/material.dart';
import 'package:trump28/helper/constants.dart';

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

  bool _playersIsLoading = true;
  bool _isPlayerTeamedUp = false;

  List<String> _teamA = [
    "Team A 1",
    "Team A 2",
    "Team A 3",
  ];

  List<String> _teamB = [
    "Team B 1",
    "Team B 2",
  ];

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

    Future.delayed(
      Duration(seconds: 1),
    ).then(
      (value) => setState(() => _playersIsLoading = false),
    );

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
      onWillPop: () {
        //  TODO : Reverse intro animation
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
                      vertical: 20.0,
                    ),
                    width: 400.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: _playersIsLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (_, __) {
                                        return Container(
                                          padding: EdgeInsets.all(10.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            _teamA[__],
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: _teamA.length,
                                    ),
                                    _isPlayerTeamedUp
                                        ? SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                        : Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () => addPlayerToTeam(
                                                  isTeamA: true),
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 25.0),
                                height: double.maxFinite,
                                color: Colors.white,
                                width: 1.0,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (_, __) {
                                        return Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            highlightColor: Colors.transparent,
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.all(10.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                _teamB[__],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: _teamB.length,
                                    ),
                                    _isPlayerTeamedUp
                                        ? SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                        : Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () => addPlayerToTeam(
                                                  isTeamA: false),
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 28,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  addPlayerToTeam({bool isTeamA}) {
    setState(() {
      //  Team logic
      isTeamA ? _teamA.add("New Player") : _teamB.add("New Player");
      _isPlayerTeamedUp = true;
    });
  }
}
