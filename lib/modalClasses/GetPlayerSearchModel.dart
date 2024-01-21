class GetPlayerSearchModel {
  int? success;
  int? code;
  String? message;
  List<GetPlayerSearchData>? body;

  GetPlayerSearchModel({this.success, this.code, this.message, this.body});

  GetPlayerSearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['body'] != null) {
      body = <GetPlayerSearchData>[];
      json['body'].forEach((v) {
        body!.add(GetPlayerSearchData.fromJson(v));
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

class GetPlayerSearchData {
  int? id;
  String? name;
  String? mobileNumber;

  GetPlayerSearchData({this.id, this.name, this.mobileNumber});

  GetPlayerSearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    return data;
  }
}
