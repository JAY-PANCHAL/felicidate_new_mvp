class DiaryDetailsResponse {
  bool? status;
  String? message;
  Data? data;

  DiaryDetailsResponse({this.status, this.message, this.data});

  DiaryDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  DiaryDetail? diaryDetail;

  Data({this.diaryDetail});

  Data.fromJson(Map<String, dynamic> json) {
    diaryDetail = json['diary_detail'] != null
        ? new DiaryDetail.fromJson(json['diary_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diaryDetail != null) {
      data['diary_detail'] = this.diaryDetail!.toJson();
    }
    return data;
  }
}

class DiaryDetail {
  int? id;
  String? journalTitle;
  String? journalDescription;
  String? journalEntryDate;
  String? createdAt;
  String? updatedAt;

  DiaryDetail(
      {this.id,
        this.journalTitle,
        this.journalDescription,
        this.journalEntryDate,
        this.createdAt,
        this.updatedAt});

  DiaryDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    journalTitle = json['journal_title'];
    journalDescription = json['journal_description'];
    journalEntryDate = json['journal_entry_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['journal_title'] = this.journalTitle;
    data['journal_description'] = this.journalDescription;
    data['journal_entry_date'] = this.journalEntryDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
