import 'package:betweeener_app/core/helpers/api_response.dart';
import 'package:betweeener_app/providers/link_provider.dart';
import 'package:betweeener_app/providers/user_provider.dart';
import 'package:betweeener_app/views_features/auth/login_view.dart';
import 'package:betweeener_app/views_features/links/add_link_view.dart';
import 'package:betweeener_app/views_features/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/util/constants.dart';

class HomeView extends StatelessWidget {
  static String id = '/homeView';
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('user');
            Navigator.pushReplacementNamed(context, LoginView.id);
          },
          icon: Icon(Icons.logout_rounded, color: Colors.red),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchView.id);
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.qr_code_scanner_outlined),
          ),
        ],
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Consumer<UserProvider>(
              builder: (_, userProvider, _) {
                if (userProvider.isLoadingUser) {
                  return Center(child: CircularProgressIndicator());
                }

                final user = userProvider.currentUser;
                if (user == null || user.user == null || user.token == null) {
                  return Center(child: Text("No user data found"));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, ${user.user!.name}!",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: QrImageView(
                        data: user.token!,
                        foregroundColor: kPrimaryColor,
                        version: QrVersions.auto,
                        backgroundColor: Colors.transparent,
                        size: 300,
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Divider(color: kPrimaryColor, thickness: 2),
            ),
            SizedBox(height: 24),
            Consumer<LinkProvider>(
              builder: (_, linkProvider, _) {
                if (linkProvider.linkList.status == Status.LOADING) {
                  return Center(child: CircularProgressIndicator());
                } else if (linkProvider.linkList.status == Status.ERROR) {
                  return Text("${linkProvider.linkList.message}");
                }
                return SizedBox(
                  height: 90,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 16),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: linkProvider.linkList.data!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == linkProvider.linkList.data!.length) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: kLightPrimaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AddLinkView.id);
                                },
                                icon: Icon(Icons.add, color: kPrimaryColor),
                              ),
                              Text(
                                "Add Link",
                                style: TextStyle(
                                  color: kPrimaryColor.withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (index < linkProvider.linkList.data!.length) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: kLightSecondaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            spacing: 12,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                linkProvider.linkList.data![index].title
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: kOnSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "@${linkProvider.linkList.data![index].username ?? "UserName"}",
                                style: TextStyle(
                                  color: kOnSecondaryColor.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
