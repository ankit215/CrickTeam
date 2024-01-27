import 'GetTeamModel.dart';

class TeamSelected {
  GetTeamData?getTeamData;
  List<Players>? players;

  TeamSelected({this.getTeamData, this.players});

  TeamSelected.fromJson(Map<String, dynamic> json) {
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(new Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.players != null) {
      data['players'] = this.players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  int? playerId;
  String? playerType;

  Players({this.playerId, this.playerType});

  Players.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerType = json['player_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_type'] = this.playerType;
    return data;
  }
}