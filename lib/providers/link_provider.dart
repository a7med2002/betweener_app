import 'package:betweeener_app/core/helpers/api_response.dart';
import 'package:flutter/foundation.dart';

import '../controllers/link_controller.dart';
import '../models/link_response_model.dart';

class LinkProvider extends ChangeNotifier {
  late LinkRepository _linkRepository;
  late ApiResponse<List<Link>> _links;

  LinkProvider() {
    _linkRepository = LinkRepository();
    _fetchLinks();
  }

  ApiResponse<List<Link>> get links => _links;

  void _fetchLinks() async {
    _links = ApiResponse.loading('Loading');
    notifyListeners();

    try {
      final response = await _linkRepository.fetchLinks();
      _links = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _links = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
