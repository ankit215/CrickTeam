class GetMatchModel {
  int? success;
  int? code;
  String? message;
  List<GetMatchData>? body;

  GetMatchModel({this.success, this.code, this.message, this.body});

  GetMatchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['body'] != null) {
      body = <GetMatchData>[];
      json['body'].forEach((v) {
        body!.add(new GetMatchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (body != null) {
      data['body'] = body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetMatchData {
  int? id;
  int? team1Id;
  int? team2Id;
  int? totalOver;
  String? city;
  String? venueGround;
  String? matchDate;
  String? matchTime;
  int? scorerId;
  int? tossWinnerId;
  int? tossDecision;
  String? matchResult;
  int? status;
  String? teamOneJson;
  String? teamTwoJson;
  String? createdAt;
  String? updatedAt;
  String? team1Name;
  String? team2Name;

  GetMatchData(
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
        this.teamOneJson,
        this.teamTwoJson,
        this.createdAt,
        this.updatedAt,
        this.team1Name,
        this.team2Name});

  GetMatchData.fromJson(Map<String, dynamic> json) {
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
    teamOneJson = json['team_one_json'];
    teamTwoJson = json['team_two_json'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    team1Name = json['team1_name'];
    team2Name = json['team2_name'];
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
    data['toss_winner_id'] = tossWinnerId;
    data['toss_decision'] = tossDecision;
    data['match_result'] = matchResult;
    data['status'] = status;
    data['team_one_json'] = teamOneJson;
    data['team_two_json'] = teamTwoJson;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['team1_name'] = team1Name;
    data['team2_name'] = team2Name;
    return data;
  }
}
