import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

class CustomCommentNotifcation extends StatefulWidget {
  const CustomCommentNotifcation({Key? key}) : super(key: key);

  @override
  State<CustomCommentNotifcation> createState() =>
      _CustomCommentNotifcationState();
}

class _CustomCommentNotifcationState extends State<CustomCommentNotifcation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/images/download.jpg"),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hamza Djamila",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: primaryColor),
            ),
            const SizedBox(height: 5),
            Text(
              "has commented on your post.",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: secondaryColor),
            ),
            const SizedBox(height: 10),
            Text(
              "5 min ago.",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: backcolor),
            ),
          ],
        ),
      ],
    );
  }
}
