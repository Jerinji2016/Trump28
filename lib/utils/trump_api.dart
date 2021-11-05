import 'package:cloud_functions/cloud_functions.dart';
import 'package:trump28/providers/game.dart';
import 'package:trump28/modals/njan.dart';

/// Class for cloud function for Trump28
class TrumpApi {
  static const CREATE_ROOM = "createRoom";
  static const JOIN_ROOM = "joinRoom";
  static const JOIN_SEAT = "joinSeat";
  static const SWAP_SEAT = "swapSeat";
  static const LEAVE_SEAT = "leaveSeat";

  /// Initializes a room and returns its ID
  static Future<Game> initializeRoom(GameType gameType) async {
    print('TrumpApi.initializeRoom: ');
    var callable = FirebaseFunctions.instance.httpsCallable(CREATE_ROOM);
    var response = await callable.call({
      "type": gameType == GameType.FourPlayer ? 4 : 6,
    });
    print(response.data);
    return Game.create(response.data);
  }

  static Future<Map> joinSeat(int seatNo, String roomId) async {
    print('TrumpApi.joinSeat: $seatNo');
    var callable = FirebaseFunctions.instance.httpsCallable(JOIN_SEAT);
    var response = await callable.call({
      "seat": seatNo,
      "roomId": roomId,
      "name": Njan().name,
    });
    print("response: ${response.data}");
    return response.data ?? false;
  }

  static Future<Map> swapSeat(String roomId, int oldSeatNo, int newSeatNo) async {
    print('TrumpApi.swapSeat: $oldSeatNo - $newSeatNo');
    var callable = FirebaseFunctions.instance.httpsCallable(SWAP_SEAT);
    var response = await callable.call({
      "oldSeat": oldSeatNo,
      "newSeat": newSeatNo,
      "roomId": roomId,
      "name": Njan().name,
    });
    print("response: ${response.data}");
    return response.data ?? false;
  }

  static Future<Map> leaveSeat(String roomId, seatNo) async {
    print('TrumpApi.leaveSeat: $seatNo');
    var callable = FirebaseFunctions.instance.httpsCallable(LEAVE_SEAT);
    var response = await callable.call({
      "seat": seatNo,
      "roomId": roomId,
    });
    print("response: ${response.data}");
    return response.data ?? false;
  }
}
