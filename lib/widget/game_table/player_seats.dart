import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/enums/game_stage.dart';
import 'package:trump28/modals/game.dart';
import 'package:trump28/modals/njan.dart';
import 'package:trump28/modals/player.dart';
import 'package:trump28/utils/trump_api.dart';
import 'package:trump28/widget/toast.dart';

import '../../main.dart';

class PlayerSeats extends StatefulWidget {
  const PlayerSeats({Key? key}) : super(key: key);

  @override
  _PlayerSeatsState createState() => _PlayerSeatsState();
}

class _PlayerSeatsState extends State<PlayerSeats> {
  final Map<int, Player?> _playerSeatMap = {};
  late Game game;

  @override
  void initState() {
    super.initState();
    game = Provider.of<Game>(context, listen: false);
    for (int i = 1; i <= game.noOfSeats; i++) _playerSeatMap.putIfAbsent(i, () => null);
  }

  @override
  void dispose() {
    TrumpApi.leaveSeat(game.roomId, game.mySeat);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PlayerSeats oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('_PlayerSeatsState.didUpdateWidget: ');
  }

  @override
  Widget build(BuildContext context) {
    game = Provider.of<Game>(context);

    _playerSeatMap.forEach((key, value) => _playerSeatMap[key] = null);

    game.players.forEach((element) {
      _playerSeatMap.update(
        element.serverSeatPosition,
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
  final int defaultSeatNo;

  Seat(this.player, this.defaultSeatNo, {Key? key}) : super(key: key);

  Alignment _getPlayerSeatAlignment(Game game) {
    int seatPosition = player?.serverSeatPosition ?? defaultSeatNo;
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

    Game game = Provider.of<Game>(context);
    return Builder(
      builder: (context) {
        return Align(
          alignment: _getPlayerSeatAlignment(game),
          child: SizedBox(
            height: size.height / 8,
            width: size.width / 7,
            child: player?.widget ?? _joinSeat(context, game),
          ),
        );
      },
    );
  }

  Widget _joinSeat(BuildContext context, Game game) => GestureDetector(
        onTap: () async {
          if (game.stage != GameStage.WaitingLobby)
            return;
          Map result = (game.haveIJoined
              ? await TrumpApi.swapSeat(
                  game.roomId,
                  game.players
                      .firstWhere(
                        (element) => element.id == Njan().id,
                      )
                      .serverSeatPosition,
                  defaultSeatNo,
                )
              : await TrumpApi.joinSeat(defaultSeatNo, game.roomId));
          if (!result["status"]) Toast.show(context, result["message"], Toast.LENGTH_SHORT);
        },
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
                          game.haveIJoined ? Icons.swap_horiz : Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          game.haveIJoined ? "Swap" : "Join",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
