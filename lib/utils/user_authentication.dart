import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trump28/modals/njan.dart';
import 'package:trump28/utils/firestore.dart';

class UserAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn;

  static const _ROOM_ID_GENERATOR_EXHAUST_COUNT = 30;

  Future<UserCredential?> signInWithGoogleAccount() async {
    _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print("error: ${e.message}");
      return null;
    }
  }

  static Future<void> setUpUser(UserCredential userCredential) async {
    print('UserAuthentication.setUpUser: ');
    User user = userCredential.user!;
    DocumentSnapshot? userSnap;
    try {
      userSnap = await Firestore.getUser(user.uid);
    } on Exception {
      print(e);
      userSnap = null;
    }
    Map userMap = (userSnap?.data() ?? {}) as Map;
    if (userMap.isEmpty)
      await _registerUser(user.uid, user.displayName!, user.phoneNumber, user.email);
    else
      Njan.initialize(userMap..putIfAbsent("id", () => user.uid));
  }

  static Future<void> registerPhoneUser(String name, UserCredential userCredential) async {
    User user = userCredential.user!;
    return await _registerUser(user.uid, name, user.phoneNumber, null);
  }

  static Future<void> _registerUser(String id, String name, String? phone, String? email) async {
    String? roomId = await generateRoomID();
    if (roomId == null) roomId = id;

    Map createdUser = await Firestore.createUser(id, name, roomId, phone, email);
    Njan.initialize(createdUser);
  }

  static String _getNewID() {
    String literals = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    int i = 0;
    Random random = Random();
    List indexes = [];

    while (i < 8) {
      int n = random.nextInt(36);
      indexes.add(n);
      i++;
    }
    return indexes.map((e) => literals[e]).toList().join("");
  }

  static Future<String?> generateRoomID() async {
    String? roomID;
    int roomGenerateCount = 0;

    while (roomGenerateCount < _ROOM_ID_GENERATOR_EXHAUST_COUNT) {
      roomID = _getNewID();
      if (!(await Firestore.checkRoomIdExists(roomID))) break;
      roomID = null;
      roomGenerateCount++;
    }
    return roomID;
  }
}
