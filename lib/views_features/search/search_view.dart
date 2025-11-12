import 'package:betweeener_app/core/helpers/api_response.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/providers/user_provider.dart';
import 'package:betweeener_app/views_features/profile/friend_profile_view.dart';
import 'package:betweeener_app/views_features/widgets/custom_text_form_field.dart';
import 'package:betweeener_app/views_features/widgets/result_search_card.dart';
import 'package:betweeener_app/views_features/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  static String id = "/searchView";
   SearchView({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 8,
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomTextFormField(
                      label: "Search By Name",
                      controller: searchController,
                      hint: "friend name ..",
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Write a valid Friend Name";
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: SecondaryButtonWidget(
                        onTap: () {
                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).searchUser(searchController.text);
                        },
                        text: "search",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Provider.of<UserProvider>(context, listen: false).usersList ==
                      null
                  ? Center(child: Text("Search Friend By Name."))
                  : Consumer<UserProvider>(
                      builder: (_, userProvider, _) {
                        if (userProvider.usersList.status == Status.LOADING) {
                          return Center(child: CircularProgressIndicator());
                        } else if (userProvider.usersList.status ==
                            Status.ERROR) {
                          return Text("${userProvider.usersList.message}");
                        }
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: userProvider.usersList.data!.length,
                          itemBuilder: (context, index) {
                            final UserClass friendUser =
                                userProvider.usersList.data![index];
                            return ResultSearchCard(
                              name: userProvider.usersList.data![index].name!,
                              email: userProvider.usersList.data![index].email!,
                              ontap: () {
                                Navigator.pushNamed(
                                  context,
                                  FriendProfileView.id,
                                  arguments: friendUser,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
              // FutureBuilder<List<UserClass>>(
              //     future: searchUsers,
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState ==
              //           ConnectionState.waiting) {
              //         return Center(child: CircularProgressIndicator());
              //       } else if (snapshot.hasError) {
              //         return Center(child: Text(snapshot.error.toString()));
              //       } else if (!snapshot.hasData || snapshot.data == null) {
              //         return Center(child: Text("No Data Returned."));
              //       } else if (snapshot.data!.isEmpty) {
              //         return Center(
              //           child: Text("No User Found for this name"),
              //         );
              //       } else {
              //         return ListView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: snapshot.data!.length,
              //           itemBuilder: (context, index) {
              //             final UserClass friendUser =
              //                 snapshot.data![index];
              //             return ResultSearchCard(
              //               name: snapshot.data![index].name!,
              //               email: snapshot.data![index].email!,
              //               ontap: () {
              //                 Navigator.pushNamed(
              //                   context,
              //                   FriendProfileView.id,
              //                   arguments: friendUser,
              //                 );
              //               },
              //             );
              //           },
              //         );
              //       }
              //     },
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
