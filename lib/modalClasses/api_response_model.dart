import 'package:crick_team/modalClasses/simple_model.dart';


class SimpleApiModel {
  int? success;
  int? code;
  String? message;
  SimpleModel? body;

  SimpleApiModel({this.success, this.code, this.message, this.body});

  SimpleApiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null ? SimpleModel.fromJson(json['body']) : null;
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