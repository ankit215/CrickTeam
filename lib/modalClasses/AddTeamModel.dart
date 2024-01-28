import 'GetTeamModel.dart';

class AddTeamModel {
  int? success;
  int? code;
  String? message;
  GetTeamData? body;

  AddTeamModel({this.success, this.code, this.message, this.body});

  AddTeamModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null ? GetTeamData.fromJson(json['body']) : null;
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

/*class GetTeamData {
  int? id;
  String? name;
  String? city;
  String? teamPhoto;
  String? updatedAt;
  String? createdAt;

  GetTeamData(
      {this.id,
        this.name,
        this.city,
        this.teamPhoto,
        this.updatedAt,
        this.createdAt});

  GetTeamData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    teamPhoto = json['team_photo'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['team_photo'] = teamPhoto;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}*/
