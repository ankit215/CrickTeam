class SimpleModel {
  String? otp;
  String? token;
  int? count;

  SimpleModel({this.otp, this.token});

  SimpleModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    token = json['token'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['token'] = token;
    data['count'] = count;
    return data;
  }
}
