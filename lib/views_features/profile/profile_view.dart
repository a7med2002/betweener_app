import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/link_response_model.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/widgets/floating_action_btn.dart';
import 'package:betweeener_app/views_features/widgets/link_card.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<User> user;
  late Future<List<LinkElement>> links;
  late Future<Map<String, dynamic>> follows;

  @override
  void initState() {
    user = getCurrentUser(context);
    links = getUserLinks();
    super.initState();
    follows = getUserFollows();
  }

  void _deleteLink(int idLink) {
    deleteLink(context, idLink)
        .then((value) {
          getUserLinks();
        })
        .catchError((error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionBtn(),
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  color: kPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(100),
                          child: Image.asset(
                            "assets/imgs/profile.png",
                            width: 85,
                            height: 85,
                          ),
                        ),
                        FutureBuilder(
                          future: user,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: Text("Loading.."));
                            } else if (snapshot.hasError) {
                              return Center(child: Text("Error !!"));
                            } else {
                              return Column(
                                spacing: 8,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.user!.name!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.user!.email!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "+9700000000",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: follows,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Laoding..");
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      } else {
                                        return Row(
                                          spacing: 8,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Text(
                                                "followers ${snapshot.data!['followers_count']}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Text(
                                                "following ${snapshot.data!['following_count']}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            FutureBuilder(
              future: links,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (!snapshot.hasData) {
                  return Center(child: Text("No Links found!"));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return LinkCard(
                          isSlidable: true,
                          title: snapshot.data![index].title,
                          link: snapshot.data![index].link,
                          color: index.isOdd
                              ? kLightDangerColor
                              : kLightPrimaryColor,
                          idLink: snapshot.data![index].id,
                          onDelete: () {
                            _deleteLink(snapshot.data![index].id);
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
