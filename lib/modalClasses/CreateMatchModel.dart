class CreateMatchModel {
  int? success;
  int? code;
  String? message;
  CreateMatchData? body;

  CreateMatchModel({this.success, this.code, this.message, this.body});

  CreateMatchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null ? CreateMatchData.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class CreateMatchData {
  int? id;
  String? team1Id;
  String? team2Id;
  String? totalOver;
  String? city;
  String? venueGround;
  String? matchDate;
  String? matchTime;
  String? scorerId;
  String? status;
  String? teamOneJson;
  String? teamTwoJson;
  String? playerList;
  String? updatedAt;
  String? createdAt;

  CreateMatchData(
      {this.id,
        this.team1Id,
        this.team2Id,
        this.totalOver,
        this.city,
        this.venueGround,
        this.matchDate,
        this.matchTime,
        this.scorerId,
        this.status,
        this.teamOneJson,
        this.teamTwoJson,
        this.playerList,
        this.updatedAt,
        this.createdAt});

  CreateMatchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    team1Id = json['team1_id'];
    team2Id = json['team2_id'];
    totalOver = json['total_over'];
    city = json['city'];
    venueGround = json['venue_ground'];
    matchDate = json['match_date'];
    matchTime = json['match_time'];
    scorerId = json['scorer_id'];
    status = json['status'];
    teamOneJson = json['team_one_json'];
    teamTwoJson = json['team_two_json'];
    playerList = json['player_list'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['team1_id'] = team1Id;
    data['team2_id'] = team2Id;
    data['total_over'] = totalOver;
    data['city'] = city;
    data['venue_ground'] = venueGround;
    data['match_date'] = matchDate;
    data['match_time'] = matchTime;
    data['scorer_id'] = scorerId;
    data['status'] = status;
    data['team_one_json'] = teamOneJson;
    data['team_two_json'] = teamTwoJson;
    data['player_list'] = playerList;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
