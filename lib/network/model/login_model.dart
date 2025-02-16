class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  int? userTypeId;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? mobileNumber;
  String? mobileVerifiedAt;
  String? appSignatureHash;
  String? providerType;
  String? profilePicture;
  String? userStatus;
  int? twoFactorEnabled;
  String? createdAt;
  String? updatedAt;
  String? cityLocation;
  String? userState;
  String? userLatlng;

  User(
      {this.id,
        this.userTypeId,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.mobileNumber,
        this.mobileVerifiedAt,
        this.appSignatureHash,
        this.providerType,
        this.profilePicture,
        this.userStatus,
        this.twoFactorEnabled,
        this.createdAt,
        this.updatedAt,
        this.cityLocation,
        this.userState,
        this.userLatlng});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userTypeId = json['user_type_id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobileNumber = json['mobile_number'];
    mobileVerifiedAt = json['mobile_verified_at'];
    appSignatureHash = json['app_signature_hash'];
    providerType = json['provider_type'];
    profilePicture = json['profile_picture'];
    userStatus = json['user_status'];
    twoFactorEnabled = json['two_factor_enabled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cityLocation = json['city_location'];
    userState = json['user_state'];
    userLatlng = json['user_latlng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type_id'] = this.userTypeId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile_number'] = this.mobileNumber;
    data['mobile_verified_at'] = this.mobileVerifiedAt;
    data['app_signature_hash'] = this.appSignatureHash;
    data['provider_type'] = this.providerType;
    data['profile_picture'] = this.profilePicture;
    data['user_status'] = this.userStatus;
    data['two_factor_enabled'] = this.twoFactorEnabled;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['city_location'] = this.cityLocation;
    data['user_state'] = this.userState;
    data['user_latlng'] = this.userLatlng;
    return data;
  }
}
