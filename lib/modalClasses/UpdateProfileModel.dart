class UpdateProfileModel {
  int? success;
  int? code;
  String? message;
  UpdateProfileData? body;

  UpdateProfileModel({this.success, this.code, this.message, this.body});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null ? new UpdateProfileData.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class UpdateProfileData {
  int? id;
  String? name;
  String? address;
  String? dob;
  String? emailAddress;
  String? image;
  String? mobileNumber;
  int? gender;
  int? type;
  int? isScorer;
  String? profilePhoto;
  String? token;
  String? createdAt;
  String? updatedAt;

  UpdateProfileData(
      {this.id,
        this.name,
        this.address,
        this.dob,
        this.emailAddress,
        this.image,
        this.mobileNumber,
        this.gender,
        this.type,
        this.isScorer,
        this.profilePhoto,
        this.token,
        this.createdAt,
        this.updatedAt});

  UpdateProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    dob = json['dob'];
    emailAddress = json['email_address'];
    image = json['image'];
    mobileNumber = json['mobile_number'];
    gender = json['gender'];
    type = json['type'];
    isScorer = json['is_scorer'];
    profilePhoto = json['profile_photo'];
    token = json['token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['dob'] = dob;
    data['email_address'] = emailAddress;
    data['image'] = image;
    data['mobile_number'] = mobileNumber;
    data['gender'] = gender;
    data['type'] = type;
    data['is_scorer'] = isScorer;
    data['profile_photo'] = profilePhoto;
    data['token'] = token;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
