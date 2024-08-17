import 'package:flutter/material.dart';
import 'package:unimate/core/utils/app_imports.dart';
import '../widgets/app_bar.dart';
import 'widgets/custom_follow_notification.dart';
import 'widgets/custom_liked_notifcation.dart';
import 'widgets/custom_comment_notification.dart';
import 'widgets/custom_post_notification.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final List newItem = ["liked", "follow", "Comment", "Post"];
  final List todayItem = ["follow", "liked", "liked"];
  final List oldesItem = ["follow", "follow", "liked", "liked"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const UniAppBar(appTitle: "Notification"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newItem.length,
                  itemBuilder: (context, index) {
                    if (newItem[index] == "follow") {
                      return const CustomFollowNotifcation();
                    } else if (newItem[index] == "liked") {
                      return const CustomLikedNotifcation();
                    } else if (newItem[index] == "Comment") {
                      return const CustomCommentNotifcation();
                    } else {
                      return const CustomPostNotifcation();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Today",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: primaryColor),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: todayItem.length,
                  itemBuilder: (context, index) {
                    return todayItem[index] == "follow"
                        ? const CustomFollowNotifcation()
                        : const CustomLikedNotifcation();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Oldest",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: primaryColor),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: oldesItem.length,
                  itemBuilder: (context, index) {
                    return oldesItem[index] == "follow"
                        ? const CustomFollowNotifcation()
                        : const CustomLikedNotifcation();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
