/// Game stages, based on this value the UI will be managed.
enum GameStage {
  /// [111]: Players to join
  WaitingLobby,

  /// [112]: Deal first half of the cards
  Dealing1,

  /// [114]: First auction from minimum (14)
  FirstAuction,

  /// [115]: Deal rest of the cards
  Dealing2,

  /// [116]: Last auction from minimum (20)
  FinalAuction,

  /// [117]: Game started
  InGame,

  /// [118]: Game over, show result
  GameOver,

  /// [199]: Somebody f**ked up the game :(
  ///
  /// __Avoid this case to happen__
  ErrorPlayerMissing,
}

extension GameStageExtension on GameStage {
  static const values = {
    GameStage.WaitingLobby: 111,
    GameStage.Dealing1: 112,
    GameStage.FirstAuction: 113,
    GameStage.Dealing2: 114,
    GameStage.FinalAuction: 115,
    GameStage.InGame: 116,
    GameStage.GameOver: 117,
    GameStage.ErrorPlayerMissing: 199,
  };

  int get code => values[this]!;

  static GameStage fromCode(int code) {
    switch (code) {
      case 111:
        return GameStage.WaitingLobby;
      case 112:
        return GameStage.Dealing1;
      case 113:
        return GameStage.FirstAuction;
      case 114:
        return GameStage.Dealing2;
      case 115:
        return GameStage.FinalAuction;
      case 116:
        return GameStage.InGame;
      case 117:
        return GameStage.GameOver;
      default:
        return GameStage.ErrorPlayerMissing;
    }
  }
}