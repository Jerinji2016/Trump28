import 'package:flutter/material.dart';
import 'package:trump28/helper/constants.dart';
import 'package:trump28/lobby/res/floating_icons.dart';

class LobbyBackground extends StatefulWidget {
  final Widget child;
  LobbyBackground({this.child});
  @override
  LobbyBackgroundState createState() => LobbyBackgroundState();
}

class LobbyBackgroundState extends State<LobbyBackground>
    with TickerProviderStateMixin {
  // AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: lobbyState,
            builder: (_, lobbyState, child) {
              Color bgColor = Colors.red;
              switch (lobbyState) {
                case LobbyState.START:
                  bgColor = Colors.blue[800];
                  break;
                case LobbyState.CREATE:
                  bgColor = Colors.green[900];
                  break;
                case LobbyState.JOIN:
                  bgColor = Colors.deepOrange[800];
                  break;
                default:
                  bgColor = Colors.blueGrey[700];
                  break;
              }
              return AnimatedContainer(
                curve: Curves.ease,
                duration: Duration(seconds: 1),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: bgColor,
              );
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Colors.white10,
                  Colors.transparent,
                  Colors.black.withOpacity(.65),
                ],
              ),
            ),
          ),
          // FloatingIconBackground(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
