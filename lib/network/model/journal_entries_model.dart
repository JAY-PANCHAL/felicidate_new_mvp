class JournalEntriesModel {
  bool? status;
  String? message;
  Data? data;

  JournalEntriesModel({this.status, this.message, this.data});

  JournalEntriesModel.fromJson(Map<String, dynamic> json) {
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
  List<MyDiaries>? myDiaries;

  Data({this.myDiaries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['my_diaries'] != null) {
      myDiaries = <MyDiaries>[];
      json['my_diaries'].forEach((v) {
        myDiaries!.add(new MyDiaries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myDiaries != null) {
      data['my_diaries'] = this.myDiaries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyDiaries {
  int? id;
  String? journalTitle;
  String? journalDescription;
  String? journalEntryDate;
  String? createdAt;
  String? updatedAt;

  MyDiaries(
      {this.id,
        this.journalTitle,
        this.journalDescription,
        this.journalEntryDate,
        this.createdAt,
        this.updatedAt});

  MyDiaries.fromJson(Map<String, dynamic> json) {
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
