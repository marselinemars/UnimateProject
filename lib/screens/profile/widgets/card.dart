import 'package:flutter/material.dart';
import 'package:unimate/services/comman_services.dart';
import '../../../core/utils/app_imports.dart';


class CustomCard extends StatefulWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  State<CustomCard> createState() => CardState();
}

class CardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: secondaryColor
          .withOpacity(0.3), // Set the color to gray with 50% transparency
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(radius: 40, backgroundImage: NetworkImage(getCurrentUseravatar())),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getCurrentUsername(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  getCurrentUserEmail(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: secondaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
