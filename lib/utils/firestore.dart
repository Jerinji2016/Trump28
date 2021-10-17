import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Firestore {
  static const ROOMS = "rooms";
  static const USERS = "users";

  static Future<bool> checkRoomIdExists(String id) async => (await FirebaseFirestore.instance.collection(ROOMS).doc(id).get()).exists;

  static Future<bool> checkUserExists(String id) async => (await FirebaseFirestore.instance.collection(USERS).doc(id).get()).exists;

  static Future<Map> createUser(String id, String name, String roomId, String? phone, String? email) async {
    Map<String, dynamic> userMap = {
      "name": name,
      "roomId": roomId,
      "phone": phone,
      "email": email,
    };
    await FirebaseFirestore.instance.collection(USERS).doc(id).set(userMap);
    return userMap..putIfAbsent("id", () => id);
  }

  static Future<DocumentSnapshot<Object?>> getUser(String id) async => await FirebaseFirestore.instance.collection(USERS).doc(id).get();
}