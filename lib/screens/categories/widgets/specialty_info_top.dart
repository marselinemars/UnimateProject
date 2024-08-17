import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SpecialtyInfoTop extends StatefulWidget {
  const SpecialtyInfoTop({super.key});

  @override
  State<SpecialtyInfoTop> createState() => _SpecialtyInfoTopState();
}

class _SpecialtyInfoTopState extends State<SpecialtyInfoTop> {
  bool isFavorite = false;
  final String lastEdited = "October 25, 2023";
  final double averageRating = 4.5;
  final String authorName = "John Doe";
  final String authorProfilePic = "assets/images/profile1.jpg";
  double userRating = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: primaryColor)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: secondaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$averageRating',
                        style:Theme.of(context).textTheme.bodySmall!.copyWith(color: backcolor2) ,
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Last Edited: $lastEdited',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: backcolor2)
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: greyWhite),
                    width: width * 0.12,
                    height: width * 0.12,
                    child: IconButton(
                      icon: Icon(
                        size: 30,
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: secondaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 20),
          child:  Text(
            'Artificial Intelligence and data science',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: primaryColor),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
