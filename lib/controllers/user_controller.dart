import 'dart:convert';

import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/views_features/auth/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

Future<User> getCurrentUser(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('user')) {
    return userFromJson(prefs.getString('user')!);
  } else {
    Navigator.pushReplacementNamed(context, LoginView.id);
    return Future.error('User Not Found');
  }
}

Future<Map<String, dynamic>> getUserFollows() async {
  final prefs = await SharedPreferences.getInstance();
  final User user = userFromJson(prefs.getString('user')!);
  final response = await http.get(
    Uri.parse(followUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> userFollow = jsonDecode(response.body);
    return userFollow;
  } else {
    return Future.error("Failed to Fetch Follows");
  }
}

Future<List<UserClass>> searchUser(String userName) async {
  final body = {'name': userName};
  late User user;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  user = userFromJson(prefs.getString('user')!);
  final response = await http.post(
    Uri.parse(searchUrl),
    body: body,
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);

    List<UserClass> resultUsers = (responseData['user'] as List)
        .map((user) => UserClass.fromJson(user))
        .toList();

    return resultUsers;
  } else {
    return Future.error("Error in Search!!");
  }
}

Future<void> followUser(Map<String, String> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.post(
    Uri.parse(followUrl),
    body: body,
    headers: {'Authorization': 'Bearer ${user.token}'},
  );

  if (response.statusCode == 200) {
    print("Follow Succesfully");
  } else {
    Future.error("Error In Follow User!");
  }
}

Future<bool> checkIfIsFollowing(int friendId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(
    Uri.parse(followUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    final List following = responseBody['following'];
    for (var friend in following) {
      if (friend['id'] == friendId) {
        return true;
      }
    }
    return false;
  } else {
    return Future.error("Failed to check follow status");
  }
}
