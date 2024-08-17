import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unimate/screens/categories/categories.dart';
import 'package:unimate/screens/groups/group_screen.dart';
import 'package:unimate/screens/groups/edit_group.dart';
import 'package:unimate/screens/home.dart';
import 'package:unimate/screens/homescreen/home_screen.dart';
import 'package:unimate/screens/homescreen/new_post.dart';
import 'package:unimate/screens/authentication/login.dart';
import 'package:unimate/screens/authentication/signup.dart';
import 'package:unimate/screens/resources/resources.dart';
import 'package:unimate/screens/profile/profile.dart';
import 'controllers/user_controller.dart';
import 'models/user_model.dart';
import 'screens/authentication/verification.dart';
import 'screens/authentication/get_started.dart';
import 'services/user_service.dart';
import 'theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart'; // Import GetX

final dio = Dio();
SharedPreferences? prefs;
UserModel? user;
final UserController userController = Get.put(UserController()); // Initialize UserController with GetX

Future<bool> myInitApp() async {
  prefs = await SharedPreferences.getInstance();
   
  user = await UserAuthentication.getLoggedUser();
  userController.setUserLoggedIn(user != null); // Set user's logged-in state using GetX
  if (user != null) {
    userController.setUserData(
            id: user!.id,
            email: user!.email,
            name: user!.name,
            avatarUrl: user!.avatarUrl);
  }
  return true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await myInitApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetMaterialApp instead of MaterialApp for GetX features
        debugShowCheckedModeBanner: false,

        home: const MyApp(),
        getPages: [
          GetPage(name: '/homescreen', page: () => const HomeScreen()),
          GetPage(name: '/newpost', page: () => const NewPost()),
          GetPage(name: '/resources', page: () => const ResourcesPage()),
          GetPage(name: '/groups', page: () => const GroupScreen()),
          GetPage(name: '/profile', page: () => const ProfileTap()),
          GetPage(name: '/categories', page: () => const Categories()),
          GetPage(name: '/home', page: () => const PageHandler()),
          GetPage(name: '/signup', page: () => const SignUpForm()),
          GetPage(name: '/login', page: () => const LoginForm()),
          GetPage(name: '/verification', page: () => const Verification()),
          GetPage(name: '/getstarted', page: () => const GetStarted()),
          GetPage(name: '/group_overview', page: () => const GroupScreen()),
          GetPage(name: '/edit_group', page: () => const EditGroupTap()),
        ],
        theme: AppTheme.customTheme(),
        builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyScrollBehavior(),
          child: child!,
        );
      },
        );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userController.isLoggedIn.value) {
        return const PageHandler();
      } else {
        return const GetStarted();
      }
    });
  }
}

class MyScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}