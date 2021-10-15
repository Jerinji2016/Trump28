import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toast {
  static const int LENGTH_SHORT = 1;
  static const int LENGTH_LONG = 3;

  static void show(BuildContext context, String message, int duration) async {
    print('Toast.show: ');
    OverlayState? overlay = Overlay.of(context);

    if (overlay == null) {
      print("overlay not null");
      return;
    }

    double _opacity = 0;
    var ss;

    OverlayEntry entry = OverlayEntry(
      maintainState: true,
      opaque: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          ss = setState;
          return Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              opacity: _opacity,
              child: Container(
                margin: EdgeInsets.only(bottom: 40.0),
                child: Material(
                  color: Colors.white.withOpacity(0.65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );

    overlay.insert(entry);
    await Future.delayed(Duration(milliseconds: 100));
    ss(() => _opacity = 1);
    await Future.delayed(Duration(seconds: duration));
    ss(() => _opacity = 0);
    await Future.delayed(Duration(milliseconds: 300));

    print("remove overlay");
    entry.remove();
  }
}
