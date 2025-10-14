import 'package:betweeener_app/core/helpers/api_base_helper.dart';

import '../core/helpers/token_helper.dart';
import '../models/link_response_model.dart';

class LinkRepository {
  Future<List<Link>?> fetchLinks() async {
    final ApiBaseHelper _helper = ApiBaseHelper();

    String token = await getToken();

    final response = await _helper.get('/links', {
      'Authorization': 'Bearer $token',
    });
    return LinkResponseModel.fromJson(response).links;
  }
}
