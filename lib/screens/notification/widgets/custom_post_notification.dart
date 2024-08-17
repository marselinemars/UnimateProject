import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

class CustomPostNotifcation extends StatelessWidget {
  const CustomPostNotifcation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/images/download.jpg"),
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
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("added new post  .  h1",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: secondaryColor))
            ],
          ),
        ),
        Image.asset(
          "assets/images/download.jpg",
          height: 70,
          width: 70,
        ),
      ],
    );
  }
}
