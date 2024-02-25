class ScorerMatchModel {
  int? success;
  int? code;
  String? message;
  ScorerMatchData? body;

  ScorerMatchModel({this.success, this.code, this.message, this.body});

  ScorerMatchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null ? ScorerMatchData.fromJson(json['body']) : null;
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

class ScorerMatchData {
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
  String? playerList;
  String? createdAt;
  String? updatedAt;

  ScorerMatchData(
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
        this.playerList,
        this.createdAt,
        this.updatedAt});

  ScorerMatchData.fromJson(Map<String, dynamic> json) {
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
    playerList = json['player_list'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['player_list'] = playerList;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
