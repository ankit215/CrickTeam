class GetTeamModel {
  int? success;
  int? code;
  String? message;
  List<GetTeamData>? body;

  GetTeamModel({this.success, this.code, this.message, this.body});

  GetTeamModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['body'] != null) {
      body = <GetTeamData>[];
      json['body'].forEach((v) {
        body!.add(new GetTeamData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetTeamData {
  int? id;
  String? name;
  String? city;
  String? teamPhoto;
  String? createdAt;
  String? updatedAt;

  GetTeamData(
      {this.id,
        this.name,
        this.city,
        this.teamPhoto,
        this.createdAt,
        this.updatedAt});

  GetTeamData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    teamPhoto = json['team_photo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['team_photo'] = this.teamPhoto;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
