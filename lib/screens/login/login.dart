import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trump28/res/font_map/custom_icons_icons.dart';
import 'package:trump28/res/trump28.dart';
import 'package:trump28/routes.dart';
import 'package:trump28/screens/login/phone_auth.dart';
import 'package:trump28/utils/loading_dialog.dart';
import 'package:trump28/utils/user_authentication.dart';
import 'package:trump28/widget/gradient_background.dart';
import 'package:trump28/widget/toast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late AnimationController _buttonAnimationController;
  late AnimationController _phoneAuthAnimationController;

  bool _isPhoneSignIn = false;

  @override
  void initState() {
    super.initState();

    _buttonAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _phoneAuthAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
  }

  Animation<double> _fadeAnimation(begin, end, intervalBegin, intervalEnd) => new Tween<double>(
        begin: begin,
        end: end,
      ).animate(
        CurvedAnimation(
          parent: _buttonAnimationController,
          curve: Interval(
            intervalBegin,
            intervalEnd,
            curve: Curves.ease,
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();

    _buttonAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _buttonAnimationController,
                    builder: (_, child) => Opacity(
                      opacity: _fadeAnimation(0.0, 1.0, 0.75, 1.0).value,
                      child: child,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50.0),
                        child: InkWell(
                          splashColor: Colors.black38,
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () => _animateBackToAuthButtons(),
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
                  ),
                  Center(
                    child: Trump28(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: AnimatedBuilder(
                animation: _buttonAnimationController,
                builder: (context, _) => _isPhoneSignIn
                    ? AnimatedBuilder(
                        builder: (BuildContext context, Widget? child) => Opacity(
                          opacity: _fadeAnimation(0.0, 1.0, 0.0, 1.0).value,
                          child: child,
                        ),
                        animation: _phoneAuthAnimationController,
                        child: PhoneAuth(
                          () {
                            _animateBackToAuthButtons();
                            return Future.value(false);
                          },
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Opacity(
                              opacity: _fadeAnimation(1.0, 0.0, 0.0, 0.75).value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: _signInWithGoogle,
                                      borderRadius: BorderRadius.circular(10.0),
                                      splashColor: Colors.transparent,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        padding: EdgeInsets.symmetric(vertical: 15.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CustomIcons.google,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              "Sign in with Google",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: _signInWithPhone,
                                      borderRadius: BorderRadius.circular(10.0),
                                      splashColor: Colors.transparent,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        padding: EdgeInsets.symmetric(vertical: 15.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CustomIcons.mobile,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              "Sign in with Mobile number",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Opacity(
                              opacity: _fadeAnimation(1.0, 0.0, 0.4, 0.9).value,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have any of the following, ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "Create",
                                      style: TextStyle(
                                        color: Colors.blue[300],
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      " one and come back!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Icon(
                                      CustomIcons.emo_sunglasses,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signInWithGoogle() async {
    UserCredential? userCredential = await UserAuthentication().signInWithGoogleAccount();
    if (userCredential == null) {
      Toast.show(context, "Sign in failed", Toast.LENGTH_SHORT);
      return;
    }
    LoadingDialog loadingDialog = LoadingDialog(context);
    loadingDialog.show("Logging in...");

    await UserAuthentication.setUpUser(userCredential);
    loadingDialog.dismiss();
    Navigator.pushReplacementNamed(context, Routes.HOME);
  }

  void _signInWithPhone() async {
    print('_LoginState._signInWithPhone: 1');
    await _animateToPhoneAuth();
    print('_LoginState._signInWithPhone: 2');
    print('_LoginState._signInWithPhone: 3');
  }

  Future get delay => Future.delayed(Duration(milliseconds: 200));

  Future<void> _animateToPhoneAuth() async {
    await _buttonAnimationController.forward(from: 0.0);
    setState(() => _isPhoneSignIn = true);
    await _phoneAuthAnimationController.forward(from: 0.0);
  }

  Future<void> _animateBackToAuthButtons() async {
    print('_LoginState._animateBackToAuthButtons: ');
    await _phoneAuthAnimationController.reverse(from: 1.0);
    setState(() => _isPhoneSignIn = false);
    await _buttonAnimationController.reverse(from: 1.0);
  }
}
