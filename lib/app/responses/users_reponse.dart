import 'dart:convert';
import 'package:flutter_starter/app/models/user.dart';

class UsersIndexResponse {
  late List<User> data;

  UsersIndexResponse({required this.data});

  UsersIndexResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      jsonDecode(json['data']).forEach((v) {
        data.add(User.fromJson(v));
      });
    }
  }
}

class UserAuthResponse {
  var data;

  UserAuthResponse({required this.data});

  UserAuthResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }
}

class UserSignOutResponse {
  var data;

  UserSignOutResponse({required this.data});

  UserSignOutResponse.fromJson(Map<String, dynamic> json) {
    data = json;
  }
}
