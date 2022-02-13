import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String id, email, username;
  static UserModel currentUser;
  UserModel({this.id, this.username, this.email});
  factory UserModel.fromJson(Map<String, dynamic> j) =>
      UserModel(email: j['email'], id: j['id'], username: j['username']);
  Map<String, dynamic> toMap() =>
      {"id": id, "email": email, "username": username};

  static UserModel sessionUser;

  static getCurrentUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var data = pref.getString("user");

    if (data != null) {
      var decode = jsonDecode(data);

      var user = await UserModel.fromJson(decode);
      sessionUser = user;

      return user;
    } else {
      sessionUser = null;
    }
  }

  static void logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("user", null);
    sessionUser == null;
    pref.commit();
  }
}
