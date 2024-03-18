class UserTeamDetailModel {
  int? success;
  int? code;
  String? message;
  UserTeamDetailData? body;

  UserTeamDetailModel({this.success, this.code, this.message, this.body});

  UserTeamDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body =
        json['body'] != null ? UserTeamDetailData.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class UserTeamDetailData {
  int? id;
  int? matchId;
  int? contestId;
  int? userId;
  List<SelectedTeam>? selectedTeam;
  String? createdAt;
  String? updatedAt;

  UserTeamDetailData(
      {this.id,
      this.matchId,
      this.contestId,
      this.userId,
      this.selectedTeam,
      this.createdAt,
      this.updatedAt});

  UserTeamDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    contestId = json['contest_id'];
    userId = json['user_id'];
    if (json['selected_team'] != null) {
      selectedTeam = <SelectedTeam>[];
      json['selected_team'].forEach((v) {
        selectedTeam!.add(SelectedTeam.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['match_id'] = matchId;
    data['contest_id'] = contestId;
    data['user_id'] = userId;
    if (selectedTeam != null) {
      data['selected_team'] = selectedTeam!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SelectedTeam {
  int? teamId;
  int? playerId;
  String? playerType;
  String? playerName;
  String? teamName;
  int? isCaptain;
  int? isViceCaption;
  dynamic points;

  SelectedTeam(
      {this.teamId,
      this.playerId,
      this.playerType,
      this.playerName,
      this.teamName,
      this.isCaptain,
      this.isViceCaption,
      this.points});

  SelectedTeam.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    playerId = json['player_id'];
    playerType = json['player_type'];
    playerName = json['player_name'];
    teamName = json['team_name'];
    isCaptain = json['is_captain'];
    isViceCaption = json['is_vice_caption'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['team_id'] = teamId;
    data['player_id'] = playerId;
    data['player_type'] = playerType;
    data['player_name'] = playerName;
    data['team_name'] = teamName;
    data['is_captain'] = isCaptain;
    data['is_vice_caption'] = isViceCaption;
    data['points'] = points;
    return data;
  }
}
