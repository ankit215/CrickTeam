
class ScoreboardModel {
  int? success;
  int? code;
  String? message;
  GetScoreData? body;

  ScoreboardModel({this.success, this.code, this.message, this.body});

  ScoreboardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null ? GetScoreData.fromJson(json['body']) : null;
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

class GetScoreData {
  List<ScoreBoardBatting>? scoreBoardBatting;
  List<ScoreBoardBowler>? scoreBoardBowler;
  List<Extraruns>? extraruns;

GetScoreData({this.scoreBoardBatting, this.scoreBoardBowler, this.extraruns});

GetScoreData.fromJson(Map<String, dynamic> json) {
    if (json['scoreBoardBatting'] != null) {
      scoreBoardBatting = <ScoreBoardBatting>[];
      json['scoreBoardBatting'].forEach((v) {
        scoreBoardBatting!.add(ScoreBoardBatting.fromJson(v));
      });
    }
    if (json['scoreBoardBowler'] != null) {
      scoreBoardBowler = <ScoreBoardBowler>[];
      json['scoreBoardBowler'].forEach((v) {
        scoreBoardBowler!.add(ScoreBoardBowler.fromJson(v));
      });
    }
    if (json['extraruns'] != null) {
      extraruns = <Extraruns>[];
      json['extraruns'].forEach((v) {
        extraruns!.add(Extraruns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (scoreBoardBatting != null) {
      data['scoreBoardBatting'] =
          scoreBoardBatting!.map((v) => v.toJson()).toList();
    }
    if (scoreBoardBowler != null) {
      data['scoreBoardBowler'] =
          scoreBoardBowler!.map((v) => v.toJson()).toList();
    }
    if (extraruns != null) {
      data['extraruns'] = extraruns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScoreBoardBatting {
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
  String? createdAt;
  String? updatedAt;
  String? playerName;
  String? bowlerName;
  String? fielderName;

  ScoreBoardBatting(
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
        this.createdAt,
        this.updatedAt,
        this.playerName,
        this.bowlerName,
        this.fielderName});

  ScoreBoardBatting.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    playerName = json['player_name'];
    bowlerName = json['bowler_name'];
    fielderName = json['fielder_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['player_name'] = playerName;
    data['bowler_name'] = bowlerName;
    data['fielder_name'] = fielderName;
    return data;
  }
}

class ScoreBoardBowler {
  int? id;
  int? matchId;
  int? teamId;
  int? playerId;
  int? runs;
  int? wicket;
  int? economy;
  int? balls;
  int? maindersOver;
  String? createdAt;
  String? updatedAt;
  String? bowlerName;

  ScoreBoardBowler(
      {this.id,
        this.matchId,
        this.teamId,
        this.playerId,
        this.runs,
        this.wicket,
        this.economy,
        this.balls,
        this.maindersOver,
        this.createdAt,
        this.updatedAt,
        this.bowlerName});

  ScoreBoardBowler.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    teamId = json['team_id'];
    playerId = json['player_id'];
    runs = json['runs'];
    wicket = json['wicket'];
    economy = json['economy'];
    balls = json['balls'];
    maindersOver = json['mainders_over'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bowlerName = json['bowler_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['match_id'] = matchId;
    data['team_id'] = teamId;
    data['player_id'] = playerId;
    data['runs'] = runs;
    data['wicket'] = wicket;
    data['economy'] = economy;
    data['balls'] = balls;
    data['mainders_over'] = maindersOver;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['bowler_name'] = bowlerName;
    return data;
  }
}

class Extraruns {
  int? type;
  int? count;

  Extraruns({this.type, this.count});

  Extraruns.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['count'] = count;
    return data;
  }
}
