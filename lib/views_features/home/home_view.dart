import 'package:betweeener_app/controllers/user_controller.dart';
import 'package:betweeener_app/core/helpers/api_response.dart';
import 'package:betweeener_app/providers/link_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late Future<List<Link>> links;

  @override
  void initState() {
    user = getLocalUser();
    // links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('Welcome ${snapshot.data?.user?.name}');
            }
            return Text('loading');
          },
        ),
        Consumer<LinkProvider>(
          builder: (_, linkProvider, __) {
            if (linkProvider.links.status == Status.LOADING) {
              return Center(child: CircularProgressIndicator());
            }
            if (linkProvider.links.status == Status.COMPLETED) {
              return SizedBox(
                height: 80,
                child: ListView.separated(
                  padding: EdgeInsets.all(12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final link = linkProvider.links.data?[index].title;
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kLinksColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '$link',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 8);
                  },
                  itemCount: linkProvider.links.data?.length ?? 0,
                ),
              );
            }

            return Text('${linkProvider.links.message}');
          },
        ),
        // FutureBuilder(
        //   future: links,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return SizedBox(
        //         height: 80,
        //         child: ListView.separated(
        //             padding: EdgeInsets.all(12),
        //             scrollDirection: Axis.horizontal,
        //             itemBuilder: (context, index) {
        //               final link = snapshot.data?[index].title;
        //               return Container(
        //                 padding: EdgeInsets.all(12),
        //                 decoration: BoxDecoration(
        //                     color: kLinksColor,
        //                     borderRadius: BorderRadius.circular(15)),
        //                 child: Text(
        //                   '$link',
        //                   style: TextStyle(color: Colors.white),
        //                 ),
        //               );
        //             },
        //             separatorBuilder: (context, index) {
        //               return SizedBox(
        //                 width: 8,
        //               );
        //             },
        //             itemCount: snapshot.data!.length),
        //       );
        //     }
        //     if (snapshot.hasError) {
        //       return Text(snapshot.error.toString());
        //     }
        //     return Text('loading');
        //   },
        // ),
      ],
    );
  }
}
