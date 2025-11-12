import 'package:betweeener_app/core/helpers/api_response.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/repos/user_repository.dart';
import 'package:betweeener_app/views_features/home/home_view.dart';
import 'package:betweeener_app/views_features/profile/profile_view.dart';
import 'package:betweeener_app/views_features/recieve/receive_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {

  //========= For Navigation Bar===============
  int index = 1;
  late List<Widget?> screensList = [
     ReceiveView(),
     HomeView(),
     ProfileView(),
  ];
  //===========================================

  User? _currentUser;
  bool isLoadingUser = true;

  late ApiResponse<User> _user;

  late ApiResponse<List<UserClass>> _usersList;
  late ApiResponse<Map<String, dynamic>> _userFollows;
  late ApiResponse<bool> _isFollowing;

  late UserRepository _userRepository;

  User? get currentUser => _currentUser;

  ApiResponse<User> get user => _user;

  ApiResponse<List<UserClass>> get usersList => _usersList;
  ApiResponse<Map<String, dynamic>> get userFollows => _userFollows;
  ApiResponse<bool> get isFollowing => _isFollowing;

  UserProvider() {
    _userRepository = UserRepository();
    getCurrentUser();
    fetchUserFollows();
    _usersList = ApiResponse.completed([]);
    _isFollowing = ApiResponse.completed(false);
  }

  void changeIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    isLoadingUser = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      _currentUser = userFromJson(prefs.getString('user')!);

      isLoadingUser = false;
      notifyListeners();
    } else {
      _currentUser = null;
    }
  }

  Future<User?> login(Map<String, String> body) async {
    _user = ApiResponse.loading("Loginig..");
    notifyListeners();
    try {
      User resultUser = await _userRepository.login(body);
      _user = ApiResponse.completed(resultUser);
      notifyListeners();
      return resultUser;
    } catch (e) {
      _user = ApiResponse.error(e.toString());
      notifyListeners();
      return null;
    }
  }

  Future<User?> register(Map<String, String> body) async {
    _user = ApiResponse.loading("Registering..");
    notifyListeners();
    try {
      User resultUser = await _userRepository.register(body);
      _user = ApiResponse.completed(resultUser);
      notifyListeners();
      return resultUser;
    } catch (e) {
      _user = ApiResponse.error(e.toString());
      notifyListeners();
      return null;
    }
  }

  void setUser(User newUser) {
    _currentUser = newUser;
    isLoadingUser = false;
    notifyListeners();
  }

  fetchUserFollows() async {
    _userFollows = ApiResponse.loading("Fetching user follows");
    notifyListeners();
    try {
      final Map<String, dynamic> followsList = await _userRepository
          .getUserFollows();
      _userFollows = ApiResponse.completed(followsList);
      notifyListeners();
    } catch (e) {
      _userFollows = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  searchUser(String userName) async {
    _usersList = ApiResponse.loading("Searching Users");
    notifyListeners();
    try {
      final List<UserClass> usersResult = await _userRepository.searchUser(
        userName,
      );
      _usersList = ApiResponse.completed(usersResult);
      notifyListeners();
    } catch (e) {
      _usersList = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  followUser(Map<String, String> body) async {
    _isFollowing = ApiResponse.loading("following user");
    notifyListeners();
    try {
      await _userRepository.followUser(body);
      _isFollowing = ApiResponse.completed(true);
      notifyListeners();
    } catch (e) {
      ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  checkIfIsFollowing(int friendId) async {
    _isFollowing = ApiResponse.loading("loading");
    notifyListeners();
    try {
      bool result = await _userRepository.checkIfIsFollowing(friendId);
      _isFollowing = ApiResponse.completed(result);
      notifyListeners();
    } catch (e) {
      _isFollowing = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
