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
  int? teamId;
  int? playerId;
  String? playerType;
  bool playerSelected = false;
  bool isCaptain = false;
  bool isViceCaptain = false;
  Players({this.teamId,this.playerId, this.playerType});

  Players.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    playerId = json['player_id'];
    playerType = json['player_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['player_id'] = this.playerId;
    data['player_type'] = this.playerType;
    return data;
  }
}
