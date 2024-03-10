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
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  int? teamId;
  int? playerId;
  String? playerType;
  bool playerSelected = false;
  int isCaptain = 0;
  int isViceCaptain = 0;
  Players({this.teamId,this.playerId, this.playerType});

  Players.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    playerId = json['player_id'];
    playerType = json['player_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = teamId;
    data['player_id'] = playerId;
    data['player_type'] = playerType;
    return data;
  }
}
/*class PlayersBettor {
  int? teamId;
  int? playerId;
  int? isCaptain;
  int? isViceCaptain;
  String? playerType;
  bool playerSelected = false;
  PlayersBettor({this.teamId,this.playerId, this.playerType, this.isCaptain, this.isViceCaptain});

  PlayersBettor.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    playerId = json['player_id'];
    playerType = json['player_type'];
    isCaptain = json['is_captain'];
    isViceCaptain = json['is_vice_caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = teamId;
    data['player_id'] = playerId;
    data['player_type'] = playerType;
    data['is_captain'] = isCaptain;
    data['is_vice_caption'] = isViceCaptain;
    return data;
  }
}*/
