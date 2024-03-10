class MyContestModel {
  int? success;
  int? code;
  String? message;
  List<MyContestData>? body;

  MyContestModel({this.success, this.code, this.message, this.body});

  MyContestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['body'] != null) {
      body = <MyContestData>[];
      json['body'].forEach((v) {
        body!.add(MyContestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (body != null) {
      data['body'] = body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyContestData {
  int? id;
  int? matchId;
  int? contestId;
  int? userId;
  String? selectedTeam;
  String? createdAt;
  String? updatedAt;
  List<PlayerList>? playerList;

  MyContestData(
      {this.id,
        this.matchId,
        this.contestId,
        this.userId,
        this.selectedTeam,
        this.createdAt,
        this.updatedAt,
        this.playerList});

  MyContestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    contestId = json['contest_id'];
    userId = json['user_id'];
    selectedTeam = json['selected_team'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['player_list'] != null) {
      playerList = <PlayerList>[];
      json['player_list'].forEach((v) {
        playerList!.add(PlayerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['match_id'] = matchId;
    data['contest_id'] = contestId;
    data['user_id'] = userId;
    data['selected_team'] = selectedTeam;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (playerList != null) {
      data['player_list'] = playerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayerList {
  int? teamId;
  int? playerId;
  String? playerType;
  String? playerName;
  String? teamName;
  int? isCaptain;
  int? isViceCaption;
  bool playerSelected = false;

  PlayerList(
      {this.teamId,
        this.playerId,
        this.playerType,
        this.playerName,
        this.teamName,
        this.isCaptain,
        this.isViceCaption});

  PlayerList.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    playerId = json['player_id'];
    playerType = json['player_type'];
    playerName = json['player_name'];
    teamName = json['team_name'];
    isCaptain = json['is_captain'];
    isViceCaption = json['is_vice_caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['team_id'] = teamId;
    data['player_id'] = playerId;
    data['player_type'] = playerType;
    data['player_name'] = playerName;
    data['team_name'] = teamName;
    data['is_captain'] = isCaptain;
    data['is_vice_caption'] = isViceCaption;
    return data;
  }
}
