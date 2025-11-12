import 'package:betweeener_app/core/helpers/api_response.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/providers/link_provider.dart';
import 'package:betweeener_app/providers/user_provider.dart';
import 'package:betweeener_app/views_features/widgets/floating_action_btn.dart';
import 'package:betweeener_app/views_features/widgets/link_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

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
                        Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${Provider.of<UserProvider>(context).currentUser!.user!.name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${Provider.of<UserProvider>(context).currentUser!.user!.email}",
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
                            Consumer<UserProvider>(
                              builder: (_, userProvider, _) {
                                if (userProvider.userFollows.status ==
                                    Status.LOADING) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (userProvider.userFollows.status ==
                                    Status.ERROR) {
                                  return Text(
                                    "${userProvider.userFollows.message}",
                                  );
                                }
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
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Text(
                                        "followers ${userProvider.userFollows.data!['followers_count']}",
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
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Text(
                                        "following ${userProvider.userFollows.data!['following_count']}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
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
            Consumer<LinkProvider>(
              builder: (_, linkProvider, _) {
                if (linkProvider.linkList.status == Status.LOADING) {
                  return Center(child: CircularProgressIndicator());
                } else if (linkProvider.linkList.status == Status.ERROR) {
                  return Text("${linkProvider.linkList.message}");
                }
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: linkProvider.linkList.data!.length,
                    itemBuilder: (context, index) {
                      return LinkCard(
                        isSlidable: true,
                        title: linkProvider.linkList.data![index].title,
                        link: linkProvider.linkList.data![index].link,
                        color: index.isOdd
                            ? kLightDangerColor
                            : kLightPrimaryColor,
                        idLink: linkProvider.linkList.data![index].id,
                        onDelete: () async {
                          await linkProvider.deleteLinkFromList(
                            linkProvider.linkList.data![index].id,
                          );
                        },
                      );
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
