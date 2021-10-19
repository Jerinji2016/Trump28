
enum GameStage {
  /// Players to join
  WaitingLobby,

  /// Dealing
  Dealing,

  /// Game in progress
  InGame,

  /// When Game complete / result
  GameOver,

  /// Player has disconnected
  ErrorPlayerMissing,
}

extension GameStageExtension on GameStage {
  static const values = {
    GameStage.WaitingLobby: 111,
    GameStage.Dealing: 112,
    GameStage.InGame: 113,
    GameStage.GameOver: 114,
    GameStage.ErrorPlayerMissing: 119,
  };

  int get code => values[this]!;

  static GameStage fromCode(int code) {
    switch (code) {
      case 111:
        return GameStage.WaitingLobby;
      case 112:
        return GameStage.Dealing;
      case 113:
        return GameStage.InGame;
      case 114:
        return GameStage.GameOver;
      default:
        return GameStage.ErrorPlayerMissing;
    }
  }
}
