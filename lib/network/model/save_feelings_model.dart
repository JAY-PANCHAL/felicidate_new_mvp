class SaveFeelingsResponse {
  bool? status;
  String? message;
  Data? data;

  SaveFeelingsResponse({this.status, this.message, this.data});

  SaveFeelingsResponse.fromJson(Map<String, dynamic> json) {
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
  String? todaysFeeling;

  Data({this.todaysFeeling});

  Data.fromJson(Map<String, dynamic> json) {
    todaysFeeling = json['todays_feeling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todays_feeling'] = this.todaysFeeling;
    return data;
  }
}
