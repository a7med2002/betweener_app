import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/widgets/link_card.dart';
import 'package:flutter/material.dart';

class FriendProfileView extends StatefulWidget {
  static String id = "/friendProfileView";
  const FriendProfileView({super.key});

  @override
  State<FriendProfileView> createState() => _FriendProfileViewState();
}

class _FriendProfileViewState extends State<FriendProfileView> {
  bool isFollowing = false;
  UserClass? userFriend;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (userFriend == null) {
      userFriend = ModalRoute.of(context)!.settings.arguments as UserClass;
      checkIfIsFollowing(userFriend!.id!)
          .then((staus) {
            if (mounted) {
              setState(() {
                isFollowing = staus;
              });
            }
          })
          .catchError((error) => print(error.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final UserClass userFriend =
    //     ModalRoute.of(context)!.settings.arguments as UserClass;

    if (userFriend == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(userFriend!.name!, style: TextStyle(color: kPrimaryColor)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          userFriend!.name!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          userFriend!.email!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final body = {
                              'followee_id': userFriend!.id!.toString(),
                            };
                            try {
                              await followUser(body);
                              if (mounted) {
                                setState(() {
                                  isFollowing = true;
                                });
                              }
                            } catch (e) {
                              print("Error: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Failed to follow user"),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isFollowing
                                  ? kPrimaryColor
                                  : kSecondaryColor,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              isFollowing ? "Following" : "Follow",
                              style: TextStyle(
                                fontSize: 14,
                                color: isFollowing
                                    ? kSecondaryColor
                                    : kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return LinkCard(
                    isSlidable: false,
                    title: "title",
                    link: "https://Instagram.com",
                    color: index.isOdd ? kLightDangerColor : kLightPrimaryColor,
                    idLink: 9,
                    onDelete: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
