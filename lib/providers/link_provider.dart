import 'package:betweeener_app/core/helpers/api_response.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/repos/link_repository.dart';
import 'package:flutter/material.dart';

class LinkProvider extends ChangeNotifier {
  late LinkRepository _linkRepository;
  late ApiResponse<List<LinkElement>> _linkList;

  ApiResponse<List<LinkElement>> get linkList => _linkList;

  LinkProvider() {
    _linkRepository = LinkRepository();
    fetchLinkList();
  }

  fetchLinkList() async {
    _linkList = ApiResponse.loading("Fetching Links..");
    notifyListeners();
    try {
      List<LinkElement> links = await _linkRepository.getUserLinks();
      _linkList = ApiResponse.completed(links);
      notifyListeners();
    } catch (e) {
      _linkList = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  addLinkToList(Map<String, String> body) async {
    try {
      await _linkRepository.addLink(body);
      final links = await _linkRepository.getUserLinks();
      _linkList = ApiResponse.completed(links);
      notifyListeners();
    } catch (e) {
      ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  updateLinkList(Map<String, String> body, int linkId) async {
    try {
      await _linkRepository.updateLink(body, linkId);
      await fetchLinkList();
    } catch (e) {
      ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  deleteLinkFromList(int linkId) async {
    try {
      await _linkRepository.deleteLink(linkId);
      await fetchLinkList();
    } catch (e) {
      ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
