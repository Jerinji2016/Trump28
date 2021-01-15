import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trump28/helper/codes.dart';
import 'package:trump28/helper/constants.dart';
import 'package:trump28/helper/udp.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> with TickerProviderStateMixin {
  AnimationController _inController, _outController;
  Animation<double> _scaleIn, _opacityIn, _scaleOut, _opacityOut;

  bool _isHostLoading = true;

  List<String> hosts = [];

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
      (value) => setState(() => _isHostLoading = false),
    );

    _inController.forward(from: 0.0);
    initialise();
    super.initState();
  }

  initialise() async {
    udp = new UDP(myIP);
    await udp.connect();

    pingHost();

    udp.onDataHandler(clientPingHandler);
  }

  @override
  void dispose() {
    _inController?.dispose();
    _outController?.dispose();
    udp?.close();
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
                    child: _isHostLoading
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
                                      hosts[__],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: hosts.length,
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

  bool gotHost = false;
  pingHost() async {
    int epoch = 0;
    while (!gotHost) {
      print("Pinging Host...$epoch");
      await Future.delayed(Duration(seconds: 3));
      String message = encode([
        REQUEST_CONN.toString(),
        myIP,
      ]);
      if (udp != null) udp.sendData(message, HOST_IP);

      if (epoch++ == 10) {
        print("Stop pinging...");
        gotHost = true;
        setState(() {
          _isHostLoading = false;
        });
      }
    }
  }

  clientPingHandler(String data) {
    List<String> message = decode(data);
    int code = int.parse(message[0]);
    if (code == ACCEPT_CONN) {
      hosts.add(message[1]);
      setState(() {
        _isHostLoading = false;
      });
    }
    print(message);
  }
}
