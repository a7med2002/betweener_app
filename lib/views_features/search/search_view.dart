import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/models/user.dart';
import 'package:betweeener_app/views_features/profile/friend_profile_view.dart';
import 'package:betweeener_app/views_features/widgets/custom_text_form_field.dart';
import 'package:betweeener_app/views_features/widgets/result_search_card.dart';
import 'package:betweeener_app/views_features/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  static String id = "/searchView";
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();
  Future<List<UserClass>>? searchUsers;
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
                          setState(() {
                            searchUsers = searchUser(searchController.text);
                          });
                        },
                        text: "search",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              searchUsers == null
                  ? Center(child: Text("Search Friend By Name."))
                  : FutureBuilder<List<UserClass>>(
                      future: searchUsers,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text("No Data Returned."));
                        } else if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Text("No User Found for this name"),
                          );
                        } else {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final UserClass friendUser =
                                  snapshot.data![index];
                              return ResultSearchCard(
                                name: snapshot.data![index].name!,
                                email: snapshot.data![index].email!,
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
