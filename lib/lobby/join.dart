import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trump28/helper/constants.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join>
    with TickerProviderStateMixin {
  AnimationController _inController, _outController;
  Animation<double> _scaleIn, _opacityIn, _scaleOut, _opacityOut;

  bool _wifiIsLoading = true;

  List<String> wifis = [
    "Mits Devices",
    "Mits Guest",
    "Mits Wifi 2",
    "Mits Wifi 3A",
    "Mits Wifi 3",
    "Sayoojyam Wifi",
    "JioFi 4G",
    "SuperSpeed Wifi 5G",
    "Mits Wifi 1",
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

    Future.delayed(
      Duration(seconds: 3),
    ).then(
      (value) => setState(() => _wifiIsLoading = false),
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
      onWillPop: () {
        lobbyState.value = LobbyState.START;
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
                    "Join Game",
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
                    child: _wifiIsLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : ListView.builder(
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
                                      wifis[__],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: wifis.length,
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
}
