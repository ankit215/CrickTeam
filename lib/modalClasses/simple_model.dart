class SimpleModel {
  String? otp;
  String? token;
  int? count;
  int? id;

  SimpleModel({this.otp, this.token});

  SimpleModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    token = json['token'];
    count = json['count'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['token'] = token;
    data['count'] = count;
    data['id'] = id;
    return data;
  }
}
