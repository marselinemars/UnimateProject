import 'package:flutter/material.dart';
import '../../core/utils/app_imports.dart';
import 'new_specialty_info.dart';
import 'specialty_info.dart';

import '../widgets/app_bar.dart';

class SearchSpecialtyPage extends StatefulWidget {
  const SearchSpecialtyPage({super.key});

  @override
  _SearchSpecialtyPageState createState() => _SearchSpecialtyPageState();
}

class _SearchSpecialtyPageState extends State<SearchSpecialtyPage> {
  List<String> universities = [
    'University A',
    'University B',
    'University C',
    'University D',
    'University E',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewSpecialtyForm()),
          );
        },
        backgroundColor: backcolor,
        child: const Icon(
          Icons.add,
          color: secondaryColor,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: const UniAppBar(appTitle: 'Search Universities'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: TextField(
            decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            labelText: 'Search',
            labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: backcolor2),
            hintText: 'Search for speciality',
            hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: backcolor2),
            prefixIcon: const Icon(Icons.search, color: primaryColor, ),
            suffixIcon: const Icon(Icons.filter_alt_rounded, color: primaryColor,),
            border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  ),
),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: universities.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SpecialtyInfo()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    width: width * 0.7,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 0, color:primaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: primaryColor,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    height: height * 0.13,
                    child: Row(children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                       Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Artificial Intelligence and data science',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: primaryColor),
                              textDirection: TextDirection.rtl,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Last Edited: 10/20/2004', // Replace with actual last edited data
                                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: backcolor2)
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 16,
                                    ),
                                    Text(
                                      '4.5', // Replace with actual rating data
                                      style: Theme.of(context).textTheme.labelSmall!.copyWith(color: backcolor2),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
