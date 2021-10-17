import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trump28/routes.dart';
import 'package:trump28/utils/firestore.dart';
import 'package:trump28/utils/loading_dialog.dart';
import 'package:trump28/utils/user_authentication.dart';
import 'package:trump28/widget/toast.dart';

import '../../main.dart';

enum PhoneAuthState { phone, otpCode, name }

class PhoneAuth extends StatefulWidget {
  final Future<bool> Function() willPopScope;

  const PhoneAuth(this.willPopScope, {Key? key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> with TickerProviderStateMixin {
  TextEditingController _phoneNoController = new TextEditingController();
  TextEditingController _verifyCodeController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();

  final UserAuthentication userAuth = UserAuthentication();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;
  String _helperText = "";

  PhoneAuthState _state = PhoneAuthState.phone;

  bool _animatorWidgetOpacity = true;
  bool _showBackToPhoneButton = false;

  final _fadeDuration = Duration(milliseconds: 200);

  UserCredential? userCredential;

  final UnderlineInputBorder _whiteBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  );

  @override
  void dispose() {
    super.dispose();

    _phoneNoController.dispose();
    _verifyCodeController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.willPopScope,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.35),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: AnimatedOpacity(
                    opacity: _animatorWidgetOpacity ? 1 : 0,
                    duration: _fadeDuration,
                    child: Builder(
                      builder: (context) {
                        switch (_state) {
                          case PhoneAuthState.phone:
                            return TextField(
                              controller: _phoneNoController,
                              decoration: InputDecoration(
                                focusedBorder: _whiteBorder,
                                enabledBorder: _whiteBorder,
                                labelText: "Enter phone number",
                                labelStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 18,
                                ),
                                helperText: _helperText,
                                helperStyle: TextStyle(color: accent),
                                alignLabelWithHint: true,
                              ),
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: Colors.white),
                            );
                          case PhoneAuthState.otpCode:
                            return TextField(
                              controller: _verifyCodeController,
                              maxLength: 6,
                              maxLengthEnforcement: MaxLengthEnforcement.enforced,
                              decoration: InputDecoration(
                                focusedBorder: _whiteBorder,
                                enabledBorder: _whiteBorder,
                                counterText: "",
                                labelText: "Enter OTP",
                                labelStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 18,
                                ),
                                helperText: _helperText,
                                helperStyle: TextStyle(color: accent),
                                alignLabelWithHint: true,
                              ),
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: Colors.white),
                            );
                          default:
                            return TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                focusedBorder: _whiteBorder,
                                enabledBorder: _whiteBorder,
                                labelText: "Enter your name",
                                labelStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 18,
                                ),
                                helperText: "This name will be displayed to all players",
                                helperStyle: TextStyle(color: accent),
                                alignLabelWithHint: true,
                              ),
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: Colors.white),
                            );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  vsync: this,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_showBackToPhoneButton)
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: _showBackToPhoneButton ? 1 : 0,
                          child: Container(
                            margin: EdgeInsets.only(right: 10.0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _changePhoneAuthState(PhoneAuthState.phone),
                                borderRadius: BorderRadius.circular(5.0),
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        "Go Back",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: Colors.blue[700],
                        child: InkWell(
                          onTap: _onButtonTap,
                          highlightColor: Colors.green,
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 50.0,
                            ),
                            child: Text(
                              (_state == PhoneAuthState.name) ? "Finish" : "Verify",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toastHelperText(String message) async {
    setState(() => _helperText = message);
    await Future.delayed(Duration(seconds: 6));
    setState(() => _helperText = "");
  }

  void _changePhoneAuthState(PhoneAuthState state) async {
    setState(() => _animatorWidgetOpacity = false);
    await Future.delayed(_fadeDuration);

    setState(() {
      _state = state;
      _animatorWidgetOpacity = true;
      _showBackToPhoneButton = state == PhoneAuthState.otpCode;
    });
  }

  void _onButtonTap() {
    switch (_state) {
      case PhoneAuthState.phone:
        _verifyPhone();
        break;
      case PhoneAuthState.otpCode:
        _verifyCode();
        break;
      case PhoneAuthState.name:
        _finishAuth();
        break;
    }
  }

  void _verifyPhone() async {
    String phone = _phoneNoController.text.trim();

    if (phone.isEmpty) {
      _toastHelperText("Phone number cannot be empty");
      return;
    }

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (phoneAuthCredentials) async {
        userCredential = await _auth.signInWithCredential(phoneAuthCredentials);
        _finishAuth();
      },
      verificationFailed: (exception) {
        print('_PhoneAuthState._verifyPhone: ${exception.message}');
        _toastHelperText("Number format: +<country-code><phone-number>");
      },
      codeSent: (verificationId, forceResendingToken) {
        print("code sent: $forceResendingToken - $verificationId");
        _verificationId = verificationId;
        _changePhoneAuthState(PhoneAuthState.otpCode);
      },
      codeAutoRetrievalTimeout: (verificationId) => print("timeOut: $verificationId"),
    );
  }

  void _verifyCode() async {
    print('_PhoneAuthState._verifyCode: ');
    if (_verificationId == null) {
      print("_verificationId is null");
      return;
    }

    String verificationCode = _verifyCodeController.text.trim();
    if (verificationCode.isEmpty) {
      _toastHelperText("Verification code cannot be empty");
      return;
    }

    print("_PhoneAuthState._verifyCode: authenticating...");
    final AuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: verificationCode);
    userCredential = await _auth.signInWithCredential(credential);

    if (userCredential == null || userCredential?.user == null) {
      Toast.show(context, "Authentication failed. Try again!", Toast.LENGTH_SHORT);
      _changePhoneAuthState(PhoneAuthState.phone);
      return;
    }

    if (await Firestore.checkUserExists(userCredential!.user!.uid)) {
      LoadingDialog loadingDialog = LoadingDialog(context);
      loadingDialog.show("Finishing setup...");
      await UserAuthentication.setUpUser(userCredential!);
      loadingDialog.dismiss();
      _proceedToHomeScreen();
    } else
      _changePhoneAuthState(PhoneAuthState.name);
  }

  void _finishAuth() async {
    print('_PhoneAuthState._finishAuth: ');
    if (userCredential == null) {
      Toast.show(context, "Authentication error. Please try again!", Toast.LENGTH_SHORT);
      _changePhoneAuthState(PhoneAuthState.phone);
    }

    String name = _nameController.text.trim();
    if (name.isEmpty) {
      Toast.show(context, "Name cannot be empty", Toast.LENGTH_SHORT);
      return;
    }

    LoadingDialog loadingDialog = LoadingDialog(context);
    loadingDialog.show("Finishing setup...");

    await UserAuthentication.registerPhoneUser(name, userCredential!);
    loadingDialog.dismiss();
    _proceedToHomeScreen();
  }

  void _proceedToHomeScreen() {
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.HOME);
  }
}
