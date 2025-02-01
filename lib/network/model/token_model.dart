class TokenModelClass {
  int? success;
  Data? data;

  TokenModelClass({this.success, this.data});

  TokenModelClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? uid;
  String? token;
  int? userType;
  String? expiresOn;
  bool? notificationStatus;

  Data(
      {this.uid,
        this.token,
        this.userType,
        this.expiresOn,
        this.notificationStatus});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    token = json['token'];
    userType = json['user_type'];
    expiresOn = json['expires_on'];
    notificationStatus = json['notification_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['user_type'] = this.userType;
    data['expires_on'] = this.expiresOn;
    data['notification_status'] = this.notificationStatus;
    return data;
  }
}
