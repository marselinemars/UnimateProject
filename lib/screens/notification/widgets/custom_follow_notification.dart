import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';
import '../../widgets/custom_botton.dart';

class CustomFollowNotifcation extends StatefulWidget {
  const CustomFollowNotifcation({Key? key}) : super(key: key);

  @override
  State<CustomFollowNotifcation> createState() =>
      _CustomFollowNotifcationState();
}

class _CustomFollowNotifcationState extends State<CustomFollowNotifcation> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/images/pic1.jpg"),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Hamza Djamila",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: primaryColor),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "New following you  .  h1",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: secondaryColor),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: follow == false ? 50 : 30),
            child: CustomButton(
              height: 40,
              color: follow == false ? gradiant : gradiant2,
              textColor: follow == false ? Colors.white : primaryColor,
              onTap: () {
                setState(() {
                  follow = !follow;
                });
              },
              text: "Follow",
            ),
          ),
        ),
      ],
    );
  }
}
