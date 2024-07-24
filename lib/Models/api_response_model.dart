import 'dart:developer';

class APIsModel {
  String? api;
  String? desc;
  String? auth;
  bool? https;
  String? link;
  String? category;

  APIsModel.fromJson(Map<String, dynamic> json) {
    try {
      api = json['API'] ?? "";
      desc = json['Description'] ?? "";
      auth = json['Auth'] ?? "";
      https = json['HTTPS'] ?? "";
      link = json['Link'] ?? "";
      category = json['Category'] ?? "";
    } catch (e) {
      log("Exception - userModel.dart - APIsModel.fromJson():$e");
    }
  }
}
