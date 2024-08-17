import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimate/screens/groups/groups.dart';
import 'package:unimate/screens/profile/profile.dart';
import 'package:unimate/screens/resources/resources.dart';
import '../controllers/user_controller.dart';
import 'categories/categories.dart';
import 'homescreen/home_screen.dart';
import 'widgets/navigation_bar.dart';


class PageHandler extends StatefulWidget {
  const PageHandler({Key? key}) : super(key: key);

  @override
  _PageHandlerState createState() => _PageHandlerState();
}

class _PageHandlerState extends State<PageHandler>
    with SingleTickerProviderStateMixin {
  int bottomSelectedIndex = 0;
  late final UserController userController;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void bottomBarIsClicked(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 20), curve: Curves.ease);
    });
  }

  void pageChangedViaSliding(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: UnavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: bottomBarIsClicked,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          pageChangedViaSliding(index);
        },
        children: const <Widget>[
          HomeScreen(),
          GroupesScreen(),
          Categories(),
          ResourcesPage(),
          ProfileTap(),
        ],
      ),
    );
  }
}
