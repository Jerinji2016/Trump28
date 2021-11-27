import 'package:cloud_functions/cloud_functions.dart';
import 'package:trump28/enums/game_type.dart';
import 'package:trump28/providers/game.dart';
import 'package:trump28/modals/njan.dart';

/// Class for cloud function for Trump28
class TrumpApi {
  static const CREATE_ROOM = "createRoom";
  static const JOIN_ROOM = "joinRoom";
  static const JOIN_SEAT = "joinSeat";
  static const SWAP_SEAT = "swapSeat";
  static const LEAVE_SEAT = "leaveSeat";

  static const PLAYER_READY = "playerReady";
  static const DEAL_FIRST_ROUND = "dealFirstRound";

  /// Initializes a room and returns its ID
  static Future<Game> initializeRoom(GameType gameType) async {
    print('TrumpApi.initializeRoom: ');
    var callable = FirebaseFunctions.instance.httpsCallable(CREATE_ROOM);
    var response = await callable.call({
      "type": gameType == GameType.FourPlayer ? 4 : 6,
    });
    print(response.data);
    return Game(response.data);
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

  static Future<bool> playerReady(String roomId, int seatNo, bool status) async {
    print('TrumpApi.playerReady: ');
    var callable = FirebaseFunctions.instance.httpsCallable(PLAYER_READY);
    var response = await callable.call({
      "roomId" : roomId,
      "seatNo": seatNo,
      "readyStatus": status,
    });
    return response.data as bool;
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

  /// Send cards shuffled for first dealing and return remaining cards after first dealing
  static Future<bool> sendShuffledCards(String roomId, String shuffledCardString) async {
    print('TrumpApi.sendShuffledCards: ');
    var callable = FirebaseFunctions.instance.httpsCallable(DEAL_FIRST_ROUND);
    var response = await callable.call({
      "roomId": roomId,
      "shuffledCardString": shuffledCardString,
    });
    print(response.data);
    return response.data;
  }
}
