import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/modals/game.dart';
import 'package:trump28/modals/player.dart';

class PlayerSeats extends StatefulWidget {
  const PlayerSeats({Key? key}) : super(key: key);

  @override
  _PlayerSeatsState createState() => _PlayerSeatsState();
}

class _PlayerSeatsState extends State<PlayerSeats> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Game game = Provider.of<Game>(context);

    return Stack(
      children: game.players
          .map(
            (playerIndex) => Seat(playerIndex),
          )
          .toList(),
    );
  }
}

class Seat extends StatelessWidget {
  final Player player;

  const Seat(this.player, {Key? key}) : super(key: key);

  Alignment _getPlayerSeatAlignment(gameData) {
    switch (player.seatPosition) {
      case Player.two:
        return (gameData.type == GameType.FourPlayer) ? Alignment.centerLeft : Alignment(-0.85, 0.6);
      case Player.three:
        return (gameData.type == GameType.FourPlayer) ? Alignment.topCenter : Alignment(-0.8, -0.7);
      case Player.four:
        return (gameData.type == GameType.FourPlayer) ? Alignment.centerRight : Alignment.topCenter;
      case Player.five:
        return Alignment(0.8, -0.7);
      case Player.six:
        return Alignment(0.85, 0.6);
      default:
        return Alignment.bottomCenter;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Game gameData = Provider.of<Game>(context, listen: false);

    return Builder(
      builder: (context) {
        return Align(
          alignment: _getPlayerSeatAlignment(gameData),
          child: SizedBox(
            height: size.height / 8,
            width: size.width / 7,
            child: player.widget,
          ),
        );
      },
    );
  }
}
