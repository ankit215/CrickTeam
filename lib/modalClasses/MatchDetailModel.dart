import 'MyContestModel.dart';

class MatchDetailModel {
  int? success;
  int? code;
  String? message;
  MatchDetailData? body;

  MatchDetailModel({this.success, this.code, this.message, this.body});

  MatchDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null ? MatchDetailData.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class MatchDetailData {
  int? id;
  int? team1Id;
  int? team2Id;
  int? totalOver;
  String? city;
  String? venueGround;
  String? matchDate;
  String? matchTime;
  int? scorerId;
  dynamic tossWinnerId;
  dynamic tossDecision;
  dynamic matchResult;
  int? status;
  dynamic inningStatus;
  String? teamOneJson;
  String? teamTwoJson;
  String? createdAt;
  String? updatedAt;
  String? team1Name;
  String? team2Name;
  String? team1Photo;
  String? team2Photo;
  List<PlayerList>? playerList;

  MatchDetailData(
      {this.id,
        this.team1Id,
        this.team2Id,
        this.totalOver,
        this.city,
        this.venueGround,
        this.matchDate,
        this.matchTime,
        this.scorerId,
        this.tossWinnerId,
        this.tossDecision,
        this.matchResult,
        this.status,
        this.inningStatus,
        this.teamOneJson,
        this.teamTwoJson,
        this.createdAt,
        this.updatedAt,
        this.team1Name,
        this.team2Name,
        this.team1Photo,
        this.team2Photo,
        this.playerList});

  MatchDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    team1Id = json['team1_id'];
    team2Id = json['team2_id'];
    totalOver = json['total_over'];
    city = json['city'];
    venueGround = json['venue_ground'];
    matchDate = json['match_date'];
    matchTime = json['match_time'];
    scorerId = json['scorer_id'];
    tossWinnerId = json['toss_winner_id'];
    tossDecision = json['toss_decision'];
    matchResult = json['match_result'];
    status = json['status'];
    inningStatus = json['inning_status'];
    teamOneJson = json['team_one_json'];
    teamTwoJson = json['team_two_json'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    team1Name = json['team1_name'];
    team2Name = json['team2_name'];
    team1Photo = json['team1_photo'];
    team2Photo = json['team2_photo'];
    if (json['playerList'] != null) {
      playerList = <PlayerList>[];
      json['playerList'].forEach((v) {
        playerList!.add(PlayerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['team1_id'] = team1Id;
    data['team2_id'] = team2Id;
    data['total_over'] = totalOver;
    data['city'] = city;
    data['venue_ground'] = venueGround;
    data['match_date'] = matchDate;
    data['match_time'] = matchTime;
    data['scorer_id'] = scorerId;
    data['toss_winner_id'] = tossWinnerId;
    data['toss_decision'] = tossDecision;
    data['match_result'] = matchResult;
    data['status'] = status;
    data['inning_status'] = inningStatus;
    data['team_one_json'] = teamOneJson;
    data['team_two_json'] = teamTwoJson;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['team1_name'] = team1Name;
    data['team2_name'] = team2Name;
    data['team1_photo'] = team1Photo;
    data['team2_photo'] = team2Photo;
    if (playerList != null) {
      data['playerList'] = playerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*class PlayerList {
  int? teamId;
  int? playerId;
  String? playerType;
  String? playerName;
  String? teamName;

  PlayerList(
      {this.teamId,
        this.playerId,
        this.playerType,
        this.playerName,
        this.teamName});

  PlayerList.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    playerId = json['player_id'];
    playerType = json['player_type'];
    playerName = json['player_name'];
    teamName = json['team_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['player_id'] = this.playerId;
    data['player_type'] = this.playerType;
    data['player_name'] = this.playerName;
    data['team_name'] = this.teamName;
    return data;
  }
}*/
