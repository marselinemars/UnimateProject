import 'package:flutter/material.dart';
import '../../core/utils/app_imports.dart';
import 'package:unimate/screens/categories/specialty_search.dart';
import 'package:unimate/screens/categories/uni_search.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text("Categories", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold , color: primaryColor),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            const Text(
              ' choose an option : ',
              style: TextStyle(
                color: primaryColor,
                fontSize: 23,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                letterSpacing: 1.25,
              ),
            ),
            SizedBox(
              height: height * 0.2,
            ),
            Container(
              width: width * 0.8,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchUniversityPage()),
                  );
                },
                child: const Text(
                  'Search Universities',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: width * 0.8,
              height: 50,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchSpecialtyPage()),
                  );
                },
                child: const Text(
                  'Search Specialties',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
