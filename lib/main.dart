import 'package:betweeener_app/providers/link_provider.dart';
import 'package:betweeener_app/providers/user_provider.dart';
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
import 'package:provider/provider.dart';
import 'core/util/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LinkProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
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
          OnBoardingView.id: (context) => OnBoardingView(),
          LoadingView.id: (context) => LoadingView(),
          LoginView.id: (context) => LoginView(),
          RegisterView.id: (context) => RegisterView(),
          HomeView.id: (context) => HomeView(),
          MainAppView.id: (context) => MainAppView(),
          ProfileView.id: (context) => ProfileView(),
          ReceiveView.id: (context) => ReceiveView(),
          AddLinkView.id: (context) => AddLinkView(),
          EditLinkView.id: (context) => EditLinkView(),
          SearchView.id: (context) => SearchView(),
          FriendProfileView.id: (contex) => FriendProfileView(),
        },
      ),
    );
  }
}
