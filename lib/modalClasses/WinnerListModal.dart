class WinnerListModel {
  int? success;
  int? code;
  String? message;
  List<WinnerListData>? body;

  WinnerListModel({this.success, this.code, this.message, this.body});

  WinnerListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['body'] != null) {
      body = <WinnerListData>[];
      json['body'].forEach((v) {
        body!.add(WinnerListData.fromJson(v));
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

class WinnerListData {
  int? id;
  int? matchId;
  int? contestId;
  int? contestFee;
  int? userId;
  String? selectedTeam;
  String? createdAt;
  String? updatedAt;
  int? totalFantasyPoint;
  BatterName? batterName;

  WinnerListData(
      {this.id,
        this.matchId,
        this.contestId,
        this.contestFee,
        this.userId,
        this.selectedTeam,
        this.createdAt,
        this.updatedAt,
        this.totalFantasyPoint,
        this.batterName});

  WinnerListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['match_id'];
    contestId = json['contest_id'];
    contestFee = json['contest_fee'];
    userId = json['user_id'];
    selectedTeam = json['selected_team'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalFantasyPoint = json['total_fantasy_point'];
    batterName = json['batter_name'] != null
        ? new BatterName.fromJson(json['batter_name'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['match_id'] = this.matchId;
    data['contest_id'] = this.contestId;
    data['contest_fee'] = this.contestFee;
    data['user_id'] = this.userId;
    data['selected_team'] = this.selectedTeam;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['total_fantasy_point'] = this.totalFantasyPoint;
    if (this.batterName != null) {
      data['batter_name'] = this.batterName!.toJson();
    }
    return data;
  }
}

class BatterName {
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

  BatterName(
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

  BatterName.fromJson(Map<String, dynamic> json) {
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['email_address'] = this.emailAddress;
    data['image'] = this.image;
    data['mobile_number'] = this.mobileNumber;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['is_scorer'] = this.isScorer;
    data['profile_photo'] = this.profilePhoto;
    data['token'] = this.token;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
