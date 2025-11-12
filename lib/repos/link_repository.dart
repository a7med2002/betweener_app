import 'package:betweeener_app/core/helpers/api_base_helper.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LinkRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<LinkElement>> getUserLinks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = userFromJson(prefs.getString('user')!);
    final response = await _helper.get("/links", {
      'Authorization': 'Bearer ${user.token}',
    });
    return Link.fromJson(response).links;
  }

  Future<dynamic> addLink(Map<String, String> body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = userFromJson(prefs.getString('user')!);
    final response = _helper.post("/links", body, {
      'Authorization': 'Bearer ${user.token}',
    });
  }

  Future<dynamic> updateLink(Map<String, String> body, int linkId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = userFromJson(prefs.getString('user')!);
    final response = await _helper.update("/links/$linkId", body, {
      'Authorization': 'Bearer ${user.token}',
    });
  }

  Future<dynamic> deleteLink(int linkId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = userFromJson(prefs.getString('user')!);
    final response = _helper.delete("/links/$linkId", {
      'Authorization': 'Bearer ${user.token}',
    });
  }
}
