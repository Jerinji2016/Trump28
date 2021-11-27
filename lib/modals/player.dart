import 'package:flutter/material.dart';

class Player {
  static const int one = 1, two = 2, three = 3, four = 4, five = 5, six = 6;
  static final List<int> fourPlayers = [one, two, three, four];
  static final List<int> sixPlayers = [one, two, three, four, five, six];

  final Map json;

  final int clientSeatPosition;

  String get id => json["id"];

  String get name => json["name"];

  int get serverSeatPosition => json["serverSeat"];

  int get noOfCards => (json["cards"] ?? []).length;

  bool isDealer = false;

  bool get isReady => json["ready"];

  Player(this.json, this.clientSeatPosition);

  Widget get widget => PlayerWidget(this);
}

class PlayerWidget extends StatelessWidget {
  final Player player;

  const PlayerWidget(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.symmetric(vertical: 3.0),
                height: 30.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: player.isReady ? Colors.white24 : Colors.red.withOpacity(0.7),
                    width: player.isReady ? 2 : 3,
                  ),
                  color: Colors.grey[800]!.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.filled(
                  player.noOfCards,
                  Container(
                    height: 5.0,
                    width: 5.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    child: Text(player.name[0].toUpperCase()),
                  ),
                  if (player.isDealer)
                    CircleAvatar(
                      backgroundColor: Colors.grey[800],
                      child: Text(
                        "D",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      radius: 8,
                    ),
                ],
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                        player.name.length > 7 ? player.name.substring(0, 8) + "..." : player.name,
                        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Container(
                      child: Text(
                        "#${player.id.substring(0, 8)}...",
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
