import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump28/screens/auth/login.dart';
import 'package:trump28/screens/auth/phone_auth.dart';
import 'package:trump28/screens/join_game.dart';
import 'package:trump28/screens/player_select.dart';

import 'modals/game.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/waiting_lobby.dart';

class Routes {
  static const String SPLASH = "/";
  static const String LOGIN = "/login";
  static const String PHONE_AUTH = "/login/phone_auth";
  static const String HOME = "/home";
  static const String PLAYER_SELECT = "/player-select";
  static const String JOIN_GAME = "/join-game";
  static const String WAITING_LOBBY = "/waiting-lobby";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => Login());
      case PHONE_AUTH:
        return MaterialPageRoute(builder: (_) => PhoneAuth());
      case HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case PLAYER_SELECT:
        return MaterialPageRoute(builder: (_) => PlayerSelect());
      case JOIN_GAME:
        return MaterialPageRoute(builder: (_) => JoinGame());
      case WAITING_LOBBY:
        if (args is Game)
          return MaterialPageRoute(builder: (_) => WaitingLobby(args));
        else {
          return MaterialPageRoute(builder: (_) => PageNotFound());
        }
      default:
        return MaterialPageRoute(builder: (_) => PageNotFound());
    }
  }
}

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 15.0,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.yellow,
                      size: 64,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Route not found!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
