/// Game stages, based on this value the UI will be managed.
enum GameStage {
  /// [111]: Players to join
  WaitingLobby,

  /// [112]: All players have __joined__ and __ready__
  AllPlayersReady,

  /// [113]: Deal first half of the cards
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
    GameStage.AllPlayersReady: 112,
    GameStage.Dealing1: 113,
    GameStage.FirstAuction: 114,
    GameStage.Dealing2: 115,
    GameStage.FinalAuction: 116,
    GameStage.InGame: 117,
    GameStage.GameOver: 118,
    GameStage.ErrorPlayerMissing: 199,
  };

  int get code => values[this]!;

  static GameStage fromCode(int code) {
    switch (code) {
      case 111:
        return GameStage.WaitingLobby;
      case 112:
        return GameStage.AllPlayersReady;
      case 113:
        return GameStage.Dealing1;
      case 114:
        return GameStage.FirstAuction;
      case 115:
        return GameStage.Dealing2;
      case 116:
        return GameStage.FinalAuction;
      case 117:
        return GameStage.InGame;
      case 118:
        return GameStage.GameOver;
      default:
        return GameStage.ErrorPlayerMissing;
    }
  }
}

/*
* WaitingLobby
* AllPlayersReady
* Dealing1
* FirstAuction
* Dealing2
* FinalAuction
* InGame
* GameOver
* */
