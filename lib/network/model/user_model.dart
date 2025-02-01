class UserModel {
  int? success;
  List<Data>? data;

  UserModel({this.success, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? dob;
  String? identificationCode;
  String? age;
  String? maritalStatus;
  String? sex;
  String? bloodType;
  String? rh;
  String? image;

  Data(
      {this.id,
        this.name,
        this.dob,
        this.identificationCode,
        this.age,
        this.maritalStatus,
        this.sex,
        this.bloodType,
        this.rh,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    identificationCode = json['identification_code'];
    age = json['age'];
    maritalStatus = json['marital_status'];
    sex = json['sex'];
    bloodType = json['blood_type'];
    rh = json['rh'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['identification_code'] = this.identificationCode;
    data['age'] = this.age;
    data['marital_status'] = this.maritalStatus;
    data['sex'] = this.sex;
    data['blood_type'] = this.bloodType;
    data['rh'] = this.rh;
    data['image'] = this.image;
    return data;
  }
}
