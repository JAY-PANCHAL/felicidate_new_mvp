class FavouriteListModel {
  bool? status;
  String? message;
  Data? data;

  FavouriteListModel({this.status, this.message, this.data});

  FavouriteListModel.fromJson(Map<String, dynamic> json) {
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
  List<FavoriteUsers>? favoriteUsers;

  Data({this.favoriteUsers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['favorite_users'] != null) {
      favoriteUsers = <FavoriteUsers>[];
      json['favorite_users'].forEach((v) {
        favoriteUsers!.add(new FavoriteUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favoriteUsers != null) {
      data['favorite_users'] =
          this.favoriteUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteUsers {
  int? id;
  String? name;
  String? email;
  String? mobileNo;

  FavoriteUsers({this.id, this.name, this.email, this.mobileNo});

  FavoriteUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    return data;
  }
}
