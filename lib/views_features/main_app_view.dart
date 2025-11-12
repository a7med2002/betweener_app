import 'package:betweeener_app/providers/user_provider.dart';
import 'package:betweeener_app/views_features/widgets/custom_floating_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAppView extends StatelessWidget {
  static String id = '/mainAppView';

  const MainAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: userProvider.screensList[userProvider.index],
      extendBody: true,
      bottomNavigationBar: CustomFloatingNavBar(
        currentIndex: userProvider.index,
        onTap: (index) => userProvider.changeIndex(index),
      ),
    );
  }
}
