class GetContestModel {
  int? success;
  int? code;
  String? message;
  List<GetContestData>? body;

  GetContestModel({this.success, this.code, this.message, this.body});

  GetContestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['body'] != null) {
      body = <GetContestData>[];
      json['body'].forEach((v) {
        body!.add(GetContestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (body != null) {
      data['body'] = body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetContestData {
  int? id;
  int? matchId;
  int? entryFee;
  int? totalParticipants;
  int? numberOfWinners;
  int? prizePool;
  String? createdAt;
  String? updatedAt;
  int? count;

  GetContestData(
      {this.id,
        this.matchId,
        this.entryFee,
        this.totalParticipants,
        this.numberOfWinners,
        this.prizePool,
        this.createdAt,
        this.updatedAt,
        this.count});

  GetContestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    entryFee = json['entry_fee'];
    totalParticipants = json['total_participants'];
    numberOfWinners = json['number_of_winners'];
    prizePool = json['prize_pool'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['match_id'] = matchId;
    data['entry_fee'] = entryFee;
    data['total_participants'] = totalParticipants;
    data['number_of_winners'] = numberOfWinners;
    data['prize_pool'] = prizePool;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['count'] = count;
    return data;
  }
}
