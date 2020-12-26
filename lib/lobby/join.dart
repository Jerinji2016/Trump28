import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_p2p/flutter_p2p.dart';
import 'package:flutter_p2p/gen/protos/protos.pb.dart';
import 'package:trump28/helper/constants.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController _inController, _outController;
  Animation<double> _scaleIn, _opacityIn, _scaleOut, _opacityOut;

  bool _wifiIsLoading = true;

  List<String> wifis = [
    "Mits Devices",
    "Mits Guest",
    "Mits Wifi 2",
    "Mits Wifi 3A",
    "Mits Wifi 3",
    "Sayoojyam Wifi",
    "JioFi 4G",
    "SuperSpeed Wifi 5G",
    "Mits Wifi 1",
  ];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Stop handling events when the app doesn't run to prevent battery draining

    if (state == AppLifecycleState.resumed) {
      _register();
    } else if (state == AppLifecycleState.paused) {
      _unregister();
    }
  }

  List<StreamSubscription> _subscriptions = [];

  Future<bool> _checkPermission() async {
    if (!await FlutterP2p.isLocationPermissionGranted()) {
      await FlutterP2p.requestLocationPermission();
      return false;
    }
    return true;
  }

  List<WifiP2pDevice> _peers = [];
  bool _isConnected = false;
  bool _isHost = false;
  String _deviceAddress = "";

  void _register() async {
    if (!await _checkPermission()) {
      return;
    }
    _subscriptions.add(FlutterP2p.wifiEvents.stateChange.listen((change) {
      // Handle wifi state change
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.connectionChange.listen((change) {
      // Handle changes of the connection
      setState(() {
        _isConnected = change.networkInfo.isConnected;
        _isHost = change.wifiP2pInfo.isGroupOwner;
        _deviceAddress = change.wifiP2pInfo.groupOwnerAddress;
      });
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.thisDeviceChange.listen((change) {
      // Handle changes of this device
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.peersChange.listen((change) {
      // Handle discovered peers
      setState(() {
        _peers = change.devices;
      });
    }));

    _subscriptions.add(FlutterP2p.wifiEvents.discoveryChange.listen((change) {
      // Handle discovery state changes
    }));

    // Register to the native events which are send to the streams above
    FlutterP2p.register();
    _discover();
  }

  void _discover() async {
    print("Before discover");
    print(_peers);
    await FlutterP2p.discoverDevices();
    print(_peers);
  }

  void _disconnect() async {
    FlutterP2p.removeGroup();
  }

  void _unregister() {
    _subscriptions.forEach(
        (subscription) => subscription.cancel()); // Cancel subscriptions
    FlutterP2p.unregister(); // Unregister from native events
  }

  @override
  void initState() {
    _inController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _outController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _scaleIn = new Tween<double>(
      begin: .75,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _inController,
      ),
    );
    _opacityIn = new Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: _inController,
      ),
    );
    _scaleOut = new Tween<double>(
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

    Future.delayed(
      Duration(seconds: 3),
    ).then(
      (value) => setState(() => _wifiIsLoading = false),
    );

    _inController.forward(from: 0.0);
    super.initState();

    _register();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _inController?.dispose();
    _outController?.dispose();
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
    _disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        lobbyState.value = LobbyState.START;
        return Future.value(false);
      },
      child: AnimatedBuilder(
        animation: _outController,
        builder: (_, __) => Opacity(
          opacity: _opacityOut.value,
          child: Transform.scale(
            scale: _scaleOut.value,
            child: __,
          ),
        ),
        child: AnimatedBuilder(
          animation: _inController,
          builder: (_, __) => Opacity(
            opacity: _opacityIn.value,
            child: Transform.scale(
              scale: _scaleIn.value,
              child: __,
            ),
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50.0),
                    child: InkWell(
                      splashColor: Colors.black38,
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () => _outController.forward(from: 0.0)
                        ..whenComplete(
                            () => lobbyState.value = LobbyState.START),
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
                Container(
                  child: Text(
                    "Join Game",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    width: 400.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: _wifiIsLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (_, __) {
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      wifis[__],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: wifis.length,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
