import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/views_features/auth/login_view.dart';
import 'package:betweeener_app/views_features/links/add_link_view.dart';
import 'package:betweeener_app/views_features/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/util/constants.dart';
import '../../models/link_response_model.dart';
import '../../models/user.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<LinkElement>> links;

  @override
  void initState() {
    user = getCurrentUser(context);
    links = getUserLinks();
    super.initState();
  }

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
      body: RefreshIndicator(
        onRefresh: () async => await getUserLinks(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading ..");
                  } else if (snapshot.hasData) {
                    return Text(
                      "Hello, ${snapshot.data!.user!.name} !",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return Text("Error !!");
                  }
                },
              ),
              SizedBox(height: 24),
              FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: QrImageView(
                        data: snapshot.data!.token!,
                        foregroundColor: kPrimaryColor,
                        version: QrVersions.auto,
                        backgroundColor: Colors.transparent,
                        size: 300,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Divider(color: kPrimaryColor, thickness: 2),
              ),
              SizedBox(height: 24),
              FutureBuilder(
                future: links,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading ..");
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      height: 90,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length + 1,
                        itemBuilder: (context, index) {
                          if (index == snapshot.data!.length) {
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
                                      Navigator.pushNamed(
                                        context,
                                        AddLinkView.id,
                                      );
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
                          } else if (index < snapshot.data!.length) {
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
                                    snapshot.data![index].title.toUpperCase(),
                                    style: TextStyle(
                                      color: kOnSecondaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "@${snapshot.data![index].username ?? "UserName"}",
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
                  } else {
                    return Text("Error !!");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
