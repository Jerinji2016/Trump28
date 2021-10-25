import 'package:flutter/material.dart';

class PlayerMissing extends StatelessWidget {
  const PlayerMissing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Icon(
              Icons.warning_amber_outlined,
              color: Colors.yellow,
              size: 64,
            ),
          ),
          Container(
            child: Text(
              "Error! Player missing",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Material(
              color: Colors.red[700],
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    "Go back",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
