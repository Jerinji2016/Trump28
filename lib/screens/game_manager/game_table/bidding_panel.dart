import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump28/enums/game_stage.dart';
import 'package:trump28/main.dart';
import 'package:trump28/modals/play_card.dart';
import 'package:trump28/providers/game.dart';
import 'package:trump28/widget/toast.dart';

class BiddingPanel extends StatefulWidget {
  const BiddingPanel({Key? key}) : super(key: key);

  @override
  _BiddingPanelState createState() => _BiddingPanelState();
}

class _BiddingPanelState extends State<BiddingPanel> with TickerProviderStateMixin {
  late ValueNotifier<int> _bid;
  late int _minCallValue;
  late Game game;

  late AnimationController _panelAnimationController;

  @override
  void initState() {
    _panelAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    super.initState();

    _panelAnimationController.forward();
  }

  void _onCallUp() => (_bid.value < 28) ? _bid.value++ : null;

  void _onCallDown() => (_bid.value > _minCallValue) ? _bid.value-- : null;

  void _callBid() async {
    if (game.myHand.selectedCard.value == null) {
      print("no vcard selected");
      Toast.show(context, "Select a card to place bid", Toast.LENGTH_SHORT);
      return;
    }
    await _panelAnimationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    game = Provider.of<Game>(context, listen: false);
    _minCallValue = game.stage == GameStage.FirstAuction ? 14 : 20;
    print('_GameAuctionPanelState.build: ');
    _bid = ValueNotifier(_minCallValue);

    return AnimatedBuilder(
      animation: _panelAnimationController,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          Tween<double>(
            begin: 300,
            end: 0,
          )
              .animate(
                CurvedAnimation(
                  parent: _panelAnimationController,
                  curve: Curves.fastLinearToSlowEaseIn,
                ),
              )
              .value,
          0,
        ),
        child: child!,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.65),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          ),
        ),
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2,
          bottom: MediaQuery.of(context).size.height * 0.1,
        ),
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          children: [
            Container(
              child: Text(
                "Selected card: ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: ValueListenableBuilder<PlayCard?>(
                valueListenable: game.myHand.selectedCard,
                builder: (context, value, _) =>
                    value?.cardLabel ??
                    Text(
                      "--",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Bid",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  ValueListenableBuilder<int>(
                    valueListenable: _bid,
                    builder: (context, value, _) => Text(
                      "$value",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Material(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30.0),
                          child: InkWell(
                            onTap: _onCallUp,
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.0),
                          child: InkWell(
                            onTap: _onCallDown,
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Material(
                        color: accent,
                        borderRadius: BorderRadius.circular(5.0),
                        child: InkWell(
                          onTap: _callBid,
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                            child: Text(
                              "Call",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
