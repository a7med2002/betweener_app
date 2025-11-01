import 'package:betweeener_app/models/user.dart';
import 'package:http/http.dart' as http;
import '../core/util/constants.dart';

Future<User> login(Map<String, String> body) async {
  final response = await http.post(Uri.parse(loginUrl), body: body);
  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception('Failed to Login');
  }
}

Future<User> register(Map<String, String> body) async {
  final response = await http.post(Uri.parse(registerUrl), body: body);
  if (response.statusCode == 201) {
    return userFromJson(response.body);
  } else {
    throw Exception('Failed to Register');
  }
}
