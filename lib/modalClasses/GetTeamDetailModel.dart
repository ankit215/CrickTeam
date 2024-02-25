class GetTeamDetailModel {
  int? success;
  int? code;
  String? message;
  List<GetTeamDetailData>? body;

  GetTeamDetailModel({this.success, this.code, this.message, this.body});

  GetTeamDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['body'] != null) {
      body = <GetTeamDetailData>[];
      json['body'].forEach((v) {
        body!.add(GetTeamDetailData.fromJson(v));
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

class GetTeamDetailData {
  int? id;
  int? teamId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? userName;
  String? mobileNumber;
  String? playerCategory;
  String? dismissalType;
  bool playerSelected = false;
  bool playerOut = false;
  bool playerNotOut = false;

  GetTeamDetailData(
      {this.id,
      this.teamId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.userName,
      this.mobileNumber,
      this.dismissalType});

  GetTeamDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userName = json['user_name'];
    mobileNumber = json['mobile_number'];
    dismissalType = json['dismissal_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['team_id'] = teamId;
    data['user_id'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['user_name'] = userName;
    data['mobile_number'] = mobileNumber;
    data['dismissal_type'] = dismissalType;
    return data;
  }
}
