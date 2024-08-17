import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

class CustomLikedNotifcation extends StatelessWidget {
  const CustomLikedNotifcation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: 80,
          width: 80,
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/pic1.jpg"),
              ),
            ),
            Positioned(
              bottom: 10,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/download.jpg"),
              ),
            ),
          ]),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                maxLines: 2,
                text: TextSpan(
                    text: "Kermache Adlene",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: primaryColor),
                    children: [
                      TextSpan(
                        text: " and \n",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: secondaryColor),
                      ),
                      const TextSpan(text: "Djelmami Ibrahim")
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Liked your post  .  h1",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: secondaryColor))
            ],
          ),
        ),
        Image.asset(
          "assets/images/pic1.jpg",
          height: 64,
          width: 64,
        ),
      ],
    );
  }
}
