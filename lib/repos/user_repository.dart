import 'package:betweeener_app/core/helpers/api_base_helper.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Map<String, dynamic>> getUserFollows() async {
    final prefs = await SharedPreferences.getInstance();
    final User user = userFromJson(prefs.getString('user')!);
    final response = await _helper.get("/follow", {
      'Authorization': 'Bearer ${user.token}',
    });
    return response;
  }

  Future<List<UserClass>> searchUser(String userName) async {
    final body = {'name': userName};
    late User user;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user = userFromJson(prefs.getString('user')!);
    final response = await _helper.post("/search", body, {
      'Authorization': 'Bearer ${user.token}',
    });
    List<UserClass> resultUsers = (response['user'] as List)
        .map((user) => UserClass.fromJson(user))
        .toList();
    return resultUsers;
  }

  Future<dynamic> followUser(Map<String, String> body) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = userFromJson(prefs.getString('user')!);
    final response = _helper.post("/follow", body, {
      'Authorization': 'Bearer ${user.token}',
    });
  }

  Future<bool> checkIfIsFollowing(int friendId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = userFromJson(prefs.getString('user')!);

    final response = await _helper.get("/follow", {
      'Authorization': 'Bearer ${user.token}',
    });

    final List following = response['following'];
    for (var friend in following) {
      if (friend['id'] == friendId) {
        return true;
      }
    }
    return false;
  }

  Future<dynamic> login(Map<String, String> body) async {
    final response = await _helper.post("/login", body, {});

    // final userJson = response['user'];
    // final token = response['token'];

    // User user = User.fromJson(userJson);
    // user.token = token;
    User user = User.fromJson({
      "user": response['user'],
      "token": response['token'],
    });
    return user;
  }

  Future<dynamic> register(Map<String, String> body) async {
    final response = await _helper.post("/register", body, {});

    // final userJson = response['user'];
    // final token = response['token'];

    // User user = User.fromJson(userJson);
    // user.token = token;

    User user = User.fromJson({
      "user": response['user'],
      "token": response['token'],
    });
    return user;
  }
}
