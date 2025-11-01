import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/views_features/links/add_link_view.dart';
import 'package:flutter/material.dart';

class FloatingActionBtn extends StatelessWidget {
  const FloatingActionBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 120),
      child: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, AddLinkView.id);
        },
        child: Icon(Icons.add, size: 40),
      ),
    );
  }
}
