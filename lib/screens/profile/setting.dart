import 'package:flutter/material.dart';
import 'package:unimate/screens/authentication/login.dart';
import 'package:unimate/services/user_service.dart';
import 'widgets/card.dart';
import 'widgets/container_setting.dart';
import '../../core/utils/app_imports.dart';
import '../../services/comman_services.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set Scaffold background to transparent
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,
        title: Text(
          'Setting',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [secondaryColor, primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card with User Information
              const CustomCard(),
              const SizedBox(height: 20),
              // Action Buttons
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ContainerSetting(
                      name: "Edit profile", icon: (Icons.arrow_forward_ios)),
                  ContainerSetting(
                      name: "Change password", icon: (Icons.arrow_forward_ios)),
                  ContainerSetting(
                      name: "Terms and Privacy",
                      icon: (Icons.arrow_forward_ios)),
                  ContainerSetting(
                      name: "Help and assistance",
                      icon: (Icons.arrow_forward_ios)),
                ],
              ),
              const SizedBox(height: 150),
              // Logout Button
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    UserAuthentication.logoutUser();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginForm()), // Replace 'LoginPage()' with your login page widget
                      (Route<dynamic> route) => false, // Remove all routes in the stack
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.exit_to_app),
                  label: const Text('Logout'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
