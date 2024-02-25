class OutPlayerModel {
  int? success;
  int? code;
  String? message;
  List<OutPlayerData>? body;

  OutPlayerModel({this.success, this.code, this.message, this.body});

  OutPlayerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['body'] != null) {
      body = <OutPlayerData>[];
      json['body'].forEach((v) {
        body!.add(OutPlayerData.fromJson(v));
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

class OutPlayerData {
  int? id;
  int? matchId;
  int? teamId;
  int? playerId;
  int? position;
  int? run;
  int? balls;
  int? fours;
  int? sixs;
  int? isStricker;
  int? isCaption;
  int? strikeRate;
  String? dismissalType;
  int? bowlerId;
  int? fielderId;
  int? fantasyPoints;
  int? isThirty;
  int? isFifty;
  int? isHundread;
  int? strikeRate30;
  int? strikeRate50;
  int? strikeRate70;
  int? economyBelow;
  int? economyAbove;
  int? threeWicket;
  String? createdAt;
  String? updatedAt;

  OutPlayerData(
      {this.id,
        this.matchId,
        this.teamId,
        this.playerId,
        this.position,
        this.run,
        this.balls,
        this.fours,
        this.sixs,
        this.isStricker,
        this.isCaption,
        this.strikeRate,
        this.dismissalType,
        this.bowlerId,
        this.fielderId,
        this.fantasyPoints,
        this.isThirty,
        this.isFifty,
        this.isHundread,
        this.strikeRate30,
        this.strikeRate50,
        this.strikeRate70,
        this.economyBelow,
        this.economyAbove,
        this.threeWicket,
        this.createdAt,
        this.updatedAt});

  OutPlayerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    teamId = json['team_id'];
    playerId = json['player_id'];
    position = json['position'];
    run = json['run'];
    balls = json['balls'];
    fours = json['fours'];
    sixs = json['sixs'];
    isStricker = json['is_stricker'];
    isCaption = json['is_caption'];
    strikeRate = json['strike_rate'];
    dismissalType = json['dismissal_type'];
    bowlerId = json['bowler_id'];
    fielderId = json['fielder_id'];
    fantasyPoints = json['fantasy_points'];
    isThirty = json['is_thirty'];
    isFifty = json['is_fifty'];
    isHundread = json['is_hundread'];
    strikeRate30 = json['strike_rate_30'];
    strikeRate50 = json['strike_rate_50'];
    strikeRate70 = json['strike_rate_70'];
    economyBelow = json['economy_below'];
    economyAbove = json['economy_above'];
    threeWicket = json['three_wicket'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['match_id'] = matchId;
    data['team_id'] = teamId;
    data['player_id'] = playerId;
    data['position'] = position;
    data['run'] = run;
    data['balls'] = balls;
    data['fours'] = fours;
    data['sixs'] = sixs;
    data['is_stricker'] = isStricker;
    data['is_caption'] = isCaption;
    data['strike_rate'] = strikeRate;
    data['dismissal_type'] = dismissalType;
    data['bowler_id'] = bowlerId;
    data['fielder_id'] = fielderId;
    data['fantasy_points'] = fantasyPoints;
    data['is_thirty'] = isThirty;
    data['is_fifty'] = isFifty;
    data['is_hundread'] = isHundread;
    data['strike_rate_30'] = strikeRate30;
    data['strike_rate_50'] = strikeRate50;
    data['strike_rate_70'] = strikeRate70;
    data['economy_below'] = economyBelow;
    data['economy_above'] = economyAbove;
    data['three_wicket'] = threeWicket;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
