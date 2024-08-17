import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/utils/app_imports.dart';
import 'feedbacks_uni.dart';

class UniInfoBottom extends StatefulWidget {
  const UniInfoBottom({super.key});

  @override
  State<UniInfoBottom> createState() => _UniInfoBottomState();
}

class _UniInfoBottomState extends State<UniInfoBottom> {
  final String lastEdited = "October 25, 2023";
  final double averageRating = 4.5;
  final String authorName = "John Doe";
  final String authorProfilePic = "assets/images/profile1.jpg";
  double userRating = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          color: white,
          height: height * 0.8,
          child: Column(
            children: [
              SizedBox(
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: const BoxDecoration(
                      color: backcolor,
                      border:
                          Border(bottom: BorderSide(color: backcolor, width: 5))),
                  tabs: [
                    Tab(
                      child: Text(
                        'Pictures',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: secondaryColor),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Feedbacks',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: secondaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns in the grid
                        crossAxisSpacing: 2.0, // Spacing between columns
                        mainAxisSpacing: 2.0, // Spacing between rows
                      ),
                      itemCount: 9, // Number of items in the grid
                      itemBuilder: (BuildContext context, int index) {
                        // You can replace the container with your image widget
                        return Container(
                            color: backcolor,
                            child: Image.asset('assets/images/ensia.png',
                                fit: BoxFit.cover));
                      },
                    ),
                    const CommentPageUni(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          height: height * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: secondaryColor,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    userRating = rating;
                  });
                  // Handle the user's rating, you can save it to a database or perform other actions
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$averageRating',
                        style: const TextStyle(fontSize: 16, color: primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Last Edited: $lastEdited',
                    style:  TextStyle(fontSize: 15, color: backcolor2),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(authorProfilePic),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Author: $authorName',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
