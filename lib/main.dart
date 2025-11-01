import 'package:betweeener_app/views_features/auth/login_view.dart';
import 'package:betweeener_app/views_features/auth/register_view.dart';
import 'package:betweeener_app/views_features/home/home_view.dart';
import 'package:betweeener_app/views_features/links/add_link_view.dart';
import 'package:betweeener_app/views_features/links/edit_link_view.dart';
import 'package:betweeener_app/views_features/loading/loading_view.dart';
import 'package:betweeener_app/views_features/main_app_view.dart';
import 'package:betweeener_app/views_features/onboarding/onbording_view.dart';
import 'package:betweeener_app/views_features/profile/friend_profile_view.dart';
import 'package:betweeener_app/views_features/profile/profile_view.dart';
import 'package:betweeener_app/views_features/recieve/receive_view.dart';
import 'package:betweeener_app/views_features/search/search_view.dart';
import 'package:flutter/material.dart';
import 'core/util/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Betweener',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kPrimaryColor,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        scaffoldBackgroundColor: kScaffoldColor,
      ),
      home: const LoadingView(),
      routes: {
        OnBoardingView.id: (context) => const OnBoardingView(),
        LoadingView.id: (context) => const LoadingView(),
        LoginView.id: (context) => const LoginView(),
        RegisterView.id: (context) => const RegisterView(),
        HomeView.id: (context) => const HomeView(),
        MainAppView.id: (context) => const MainAppView(),
        ProfileView.id: (context) => const ProfileView(),
        ReceiveView.id: (context) => const ReceiveView(),
        AddLinkView.id: (context) => const AddLinkView(),
        EditLinkView.id: (context) => const EditLinkView(),
        SearchView.id: (context) => const SearchView(),
        FriendProfileView.id: (contex) => const FriendProfileView(),
      },
    );
  }
}
