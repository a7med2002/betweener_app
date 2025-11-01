import 'dart:convert';

import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/link_response_model.dart';
import 'package:http/http.dart' as http;

Future<List<LinkElement>> getUserLinks() async {
  late User user;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  user = userFromJson(prefs.getString('user')!);
  final response = await http.get(
    Uri.parse(linksUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    Link linksData = Link.fromJson(responseBody);
    return linksData.links;
  } else {
    return Future.error("Error Fetch Links !!");
  }
}

Future<void> addLink(BuildContext context, Map<String, String> body) async {
  late User user;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  user = userFromJson(prefs.getString('user')!);
  final response = await http.post(
    Uri.parse(linksUrl),
    body: body,
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Link Added Successfully ✅")));
  } else {
    Future.error("Error Add Link !!");
  }
}

Future<void> updateLink(
  BuildContext context,
  Map<String, String> body,
  int linkId,
) async {
  late User user;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  user = userFromJson(prefs.getString('user')!);
  final response = await http.put(
    Uri.parse('$linksUrl/$linkId'),
    body: body,
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Link Updated Successfully ✅")));
  } else {
    throw Exception("Error in update link!");
  }
}

Future<void> deleteLink(BuildContext context, int linkId) async {
  late User user;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  user = userFromJson(prefs.getString('user')!);
  final response = await http.delete(
    Uri.parse("$linksUrl/$linkId"),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Link Deleted Successfully ✅")));
  } else {
    throw Exception("Error in delete link!");
  }
}
