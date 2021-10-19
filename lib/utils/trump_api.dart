import 'package:cloud_functions/cloud_functions.dart';
import 'package:trump28/modals/game.dart';

class TrumpApi {
  static const CREATE_ROOM = "createRoom";

  /// Initializes a room and returns its ID
  static Future<Game> initializeRoom(GameType gameType) async {
    var callable = FirebaseFunctions.instance.httpsCallable(CREATE_ROOM);
    var response = await callable.call({
      "type": gameType == GameType.FourPlayer ? 4 : 6,
    });
    print(response.data);
    return Game.create(response.data);
  }
}