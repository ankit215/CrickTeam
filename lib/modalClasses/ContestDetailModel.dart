class ContestDetailModel {
  int? success;
  int? code;
  String? message;
  ContestDetailData? body;

  ContestDetailModel({this.success, this.code, this.message, this.body});

  ContestDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null ? ContestDetailData.fromJson(json['body']) : null;
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

class ContestDetailData {
  int? id;
  int? matchId;
  int? entryFee;
  int? totalParticipants;
  int? numberOfWinners;
  int? prizePool;
  String? createdAt;
  String? updatedAt;
  List<Player>? player;

  ContestDetailData(
      {this.id,
        this.matchId,
        this.entryFee,
        this.totalParticipants,
        this.numberOfWinners,
        this.prizePool,
        this.createdAt,
        this.updatedAt,
        this.player});

  ContestDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    entryFee = json['entry_fee'];
    totalParticipants = json['total_participants'];
    numberOfWinners = json['number_of_winners'];
    prizePool = json['prize_pool'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['player'] != null) {
      player = <Player>[];
      json['player'].forEach((v) {
        player!.add(Player.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['match_id'] = matchId;
    data['entry_fee'] = entryFee;
    data['total_participants'] = totalParticipants;
    data['number_of_winners'] = numberOfWinners;
    data['prize_pool'] = prizePool;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (player != null) {
      data['player'] = player!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Player {
  int? id;
  int? matchId;
  int? contestId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? userName;

  Player(
      {this.id,
        this.matchId,
        this.contestId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.userName});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    contestId = json['contest_id'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['match_id'] = matchId;
    data['contest_id'] = contestId;
    data['user_id'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['user_name'] = userName;
    return data;
  }
}
