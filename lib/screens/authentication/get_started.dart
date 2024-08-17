import 'package:flutter/material.dart';
import '../../core/utils/app_imports.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor], // Adjust the colors as needed
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.2,
            ),
            Image.asset(
              'assets/images/unimate_logo.png',
              height: height * 0.5,
            ),
            SizedBox(
              height: height * 0.15,
            ),
            Container(
              height: 50.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor, secondaryColor], // Add your gradient colors here
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child:  Text(
                  "Get Started ",
                  style: MyTextStyles.bodyText1.copyWith(color: white),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
