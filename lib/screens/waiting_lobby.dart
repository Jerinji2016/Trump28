import 'package:flutter/material.dart';
import 'package:trump28/widget/game_table/game_table.dart';
import 'package:trump28/widget/game_table/table_bg.dart';

class WaitingLobby extends StatefulWidget {
  final dynamic args;

  const WaitingLobby(this.args, {Key? key}) : super(key: key);

  @override
  _WaitingLobbyState createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50.0),
                      child: InkWell(
                        splashColor: Colors.black38,
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () => Navigator.pop(context),
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
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 30.0,
                      ),
                      child: Text(
                        "Waiting for players",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  width: 500.0,
                  decoration: BoxDecoration(
                  color: Colors.red,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: GameTable(4),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 25.0,
            right: 25.0,
            child: Material(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "START",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
