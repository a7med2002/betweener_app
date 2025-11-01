import 'package:betweeener_app/core/util/constants.dart';
import 'package:flutter/material.dart';

class CustomSharingTile extends StatelessWidget {
  const CustomSharingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      tileColor: kLightPrimaryColor,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      leading: Icon(Icons.person, size: 40),
      title: Text("AHMED ALI", style: TextStyle(fontSize: 18)),
    );
  }
}
