class ConnectToFeliModel {
  bool? status;
  String? message;
  Data? data;

  ConnectToFeliModel({this.status, this.message, this.data});

  ConnectToFeliModel.fromJson(Map<String, dynamic> json) {
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
  AvailableUser? availableUser;

  Data({this.availableUser});

  Data.fromJson(Map<String, dynamic> json) {
    availableUser = json['available_user'] != null
        ? new AvailableUser.fromJson(json['available_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.availableUser != null) {
      data['available_user'] = this.availableUser!.toJson();
    }
    return data;
  }
}

class AvailableUser {
  int? id;
  String? talkerName;
  String? talkerEmail;
  String? talkerMobile;
  Null? zegoCallId;

  AvailableUser(
      {this.id,
        this.talkerName,
        this.talkerEmail,
        this.talkerMobile,
        this.zegoCallId});

  AvailableUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talkerName = json['talker_name'];
    talkerEmail = json['talker_email'];
    talkerMobile = json['talker_mobile'];
    zegoCallId = json['zego_call_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talker_name'] = this.talkerName;
    data['talker_email'] = this.talkerEmail;
    data['talker_mobile'] = this.talkerMobile;
    data['zego_call_id'] = this.zegoCallId;
    return data;
  }
}
