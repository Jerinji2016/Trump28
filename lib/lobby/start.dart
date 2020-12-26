import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trump28/helper/constants.dart';
import 'package:trump28/res/trump28.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> with TickerProviderStateMixin {
  AnimationController _inController, _outController;
  Animation<double> _logoTranslateIn,
      _logoOpacityIn,
      _nameTranslateIn,
      _nameOpacityIn,
      _buttonTranslateIn,
      _buttonOpacityIn;

  Animation<double> _zoomOut, _opacityOut;

  @override
  dispose() {
    _inController?.dispose();
    _outController?.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    _inController = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _outController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _logoTranslateIn = new Tween<double>(
      begin: -20,
      end: 0,
    ).animate(
      CurvedAnimation(
        curve: Interval(0, .5, curve: Curves.ease),
        parent: _inController,
      ),
    );
    _logoOpacityIn = new Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Interval(0, 0.5, curve: Curves.ease),
        parent: _inController,
      ),
    );
    _nameTranslateIn = new Tween<double>(
      begin: -20,
      end: 0,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.3, 0.8, curve: Curves.ease),
        parent: _inController,
      ),
    );
    _nameOpacityIn = new Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.3, 0.8, curve: Curves.ease),
        parent: _inController,
      ),
    );
    _buttonTranslateIn = new Tween<double>(
      begin: -30,
      end: 0,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.6, 1, curve: Curves.ease),
        parent: _inController,
      ),
    );
    _buttonOpacityIn = new Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.6, 1, curve: Curves.ease),
        parent: _inController,
      ),
    );

    _zoomOut = new Tween<double>(
      begin: 1,
      end: 1.3,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _outController,
      ),
    );
    _opacityOut = new Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _outController,
      ),
    );

    _inController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _outController,
      builder: (_, __) => Opacity(
        opacity: _opacityOut.value,
        child: Transform.scale(
          scale: _zoomOut.value,
          child: __,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: fadeIn(
              controller: _inController,
              translate: _logoTranslateIn,
              opacity: _logoOpacityIn,
              child: Container(
                child: Center(
                  //  TODO : Add animation to logo text via perspective
                  //  https://medium.com/flutter/perspective-on-flutter-6f832f4d912e
                  child: Trump28(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: fadeIn(
              controller: _inController,
              translate: _nameTranslateIn,
              opacity: _nameOpacityIn,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: name,
                      builder: (_, __, ___) => Text(
                        __,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () => editName(context),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: fadeIn(
              controller: _inController,
              translate: _buttonTranslateIn,
              opacity: _buttonOpacityIn,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.white, width: 3.0),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () async {
                            _outController.forward(from: 0.0).whenComplete(
                                () => lobbyState.value = LobbyState.CREATE);
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.green[800],
                          child: Container(
                            height: 120.0,
                            width: 150.0,
                            alignment: Alignment.center,
                            child: Text(
                              "Create\nGame",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.white, width: 3.0),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.0),
                          onTap: () async {
                            _outController.forward(from: 0.0).whenComplete(
                                () => lobbyState.value = LobbyState.JOIN);
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.deepOrange[800],
                          child: Container(
                            height: 120.0,
                            width: 150.0,
                            alignment: Alignment.center,
                            child: Text(
                              "Join\nGame",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fadeIn({
    @required Animation translate,
    @required Animation opacity,
    @required Widget child,
    @required AnimationController controller,
  }) =>
      AnimatedBuilder(
        animation: controller,
        builder: (_, __) => Transform.translate(
          offset: Offset(0, translate.value),
          child: Opacity(
            opacity: opacity.value,
            child: child,
          ),
        ),
      );

  editName(BuildContext context) async {
    TextEditingController _controller = new TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: SimpleDialog(
          elevation: 10.0,
          backgroundColor: Colors.black38,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Change Name",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 2.0,
              color: Colors.white70,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _controller,
                maxLength: 8,
                maxLengthEnforced: true,
                keyboardType: TextInputType.name,
                maxLines: 1,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: name.value,
                  hintStyle: TextStyle(color: Colors.white60),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.orange[800],
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.orange[500],
                  borderRadius: BorderRadius.circular(10.0),
                  onTap: () {
                    //  TODO: Also set name in shared preferences
                    name.value = _controller.text.trim();
                    print("Name set ${_controller.text.trim()}");

                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
