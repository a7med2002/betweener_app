import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/views_features/widgets/custom_sharing_tile.dart';
import 'package:flutter/material.dart';

class ReceiveView extends StatelessWidget {
  static String id = '/receiveView';

  const ReceiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,

        title: Text("Active Sharing"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          spacing: 32,
          children: [
            Center(
              child: Icon(
                Icons.emergency_share,
                color: kLightPrimaryColor,
                size: 200,
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemCount: 3,
                itemBuilder: (context, index) => CustomSharingTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
