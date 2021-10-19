import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/modals/game.dart';
import 'package:trump28/modals/player.dart';
import 'package:trump28/utils/trump_api.dart';

import '../../main.dart';

class PlayerSeats extends StatefulWidget {
  const PlayerSeats({Key? key}) : super(key: key);

  @override
  _PlayerSeatsState createState() => _PlayerSeatsState();
}

class _PlayerSeatsState extends State<PlayerSeats> {
  final Map<int, Player?> _playerSeatMap = {};
  late final Game game;

  @override
  void initState() {
    super.initState();
    game = Provider.of<Game>(context, listen: false);
    for (int i = 1; i <= game.noOfSeats; i++) _playerSeatMap.putIfAbsent(i, () => null);
  }

  @override
  Widget build(BuildContext context) {
    game.players.forEach((element) {
      _playerSeatMap.update(
        element.seatPosition,
        (value) => element,
      );
    });

    return Stack(
      children: _playerSeatMap.keys
          .map(
            (key) => Seat(_playerSeatMap[key], key),
          )
          .toList(),
    );
  }
}

class Seat extends StatelessWidget {
  final Player? player;
  final int seatNo;

  const Seat(this.player, this.seatNo, {Key? key}) : super(key: key);

  Alignment _getPlayerSeatAlignment(Game game) {
    int seatPosition = (game.haveIJoined ? player?.seatPosition : player?.serverSeatPosition) ?? seatNo;
    switch (seatPosition) {
      case Player.two:
        return (game.type == GameType.FourPlayer) ? Alignment.centerLeft : Alignment(-0.85, 0.6);
      case Player.three:
        return (game.type == GameType.FourPlayer) ? Alignment.topCenter : Alignment(-0.8, -0.7);
      case Player.four:
        return (game.type == GameType.FourPlayer) ? Alignment.centerRight : Alignment.topCenter;
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

    Game game = Provider.of<Game>(context, listen: false);

    return Builder(
      builder: (context) {
        return Align(
          alignment: _getPlayerSeatAlignment(game),
          child: SizedBox(
            height: size.height / 8,
            width: size.width / 7,
            child: player?.widget ?? _joinSeat(),
          ),
        );
      },
    );
  }

  Widget _joinSeat() => GestureDetector(
    onTap: () => TrumpApi.joinSeat(seatNo),
    child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              color: accent,
              child: Container(
                padding: EdgeInsets.all(3.0),
                child: Material(
                  color: Colors.blueGrey[800],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                            color: Colors.white,
                        ),
                        Text(
                          "Join",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
  );
}
