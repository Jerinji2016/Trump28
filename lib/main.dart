import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trump28/helper/constants.dart';
import 'package:trump28/lobby/create.dart';
import 'package:trump28/lobby/join.dart';
import 'package:trump28/lobby/res/background.dart';
import 'package:trump28/lobby/start.dart';
import 'package:trump28/lobby/waiting_lobby.dart';
import 'package:wifi/wifi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft]);

  myIP = await Wifi.ip;
  print("My IP: $myIP");

  await SystemChrome.setEnabledSystemUIOverlays([]);
  SharedPreferences pref = await SharedPreferences.getInstance();
  name.value = pref.getString('name') ?? "Player";

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Trump28Game(),
    ),
  );
}

class Trump28Game extends StatefulWidget {
  @override
  _Trump28GameState createState() => _Trump28GameState();
}

class _Trump28GameState extends State<Trump28Game> {
  From from;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LobbyBackground(
        child: ValueListenableBuilder(
          valueListenable: lobbyState,
          builder: (_, __, ___) {
            switch (__) {
              case LobbyState.START:
                return Start();
              case LobbyState.CREATE:
                from = From.CREATE;
                return Create();
              case LobbyState.JOIN:
                from = From.JOIN;
                return Join();
              case LobbyState.WAITING:
                return WaitingLobby(from);
              default:
                return Start();
            }
          },
        ),
      ),
    );
  }
}
