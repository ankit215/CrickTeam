class PlayerDetail {
  final String player1Name;
  final String player2Name;
  final String bowlerName;
  final int player1Id;
  final int player2Id;
  final int bowlerId;

  PlayerDetail({
    required this.player1Name,
    required this.player2Name,
    required this.bowlerName,
    required this.player1Id,
    required this.player2Id,
    required this.bowlerId,
  });

  factory PlayerDetail.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> playerDetailJson = json['getPlayerDetail'];
    return PlayerDetail(
      player1Name: playerDetailJson['player1_name'],
      player2Name: playerDetailJson['player2_name'],
      bowlerName: playerDetailJson['bowler_name'],
      player1Id: playerDetailJson['player1_id'],
      player2Id: playerDetailJson['player2_id'],
      bowlerId: playerDetailJson['bowler_id'],
    );
  }
}
