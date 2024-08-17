import 'package:get/get.dart';
import 'package:unimate/models/post_model.dart';
import 'package:unimate/screens/profile/setting.dart';
import '../../controllers/user_controller.dart';
import '../../main.dart';
import 'edit_profile.dart';
import 'widgets/custom_post_item_widget.dart';
import 'widgets/custom_collection_widget.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_imports.dart';
import 'widgets/custom_binary_option.dart';
import '../../services/profile_service.dart';
import '../../services/comman_services.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({
    Key? key,
    this.showFollowBottomInProfile = false,
  }) : super(key: key);

  final bool showFollowBottomInProfile;
  


  @override
  _ProfileTapState createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  bool lr = false;
  
  @override
  Widget build(BuildContext context) {
    String userId = userController.userName.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Setting()),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                      CircleAvatar(radius: 60, backgroundImage: NetworkImage(getCurrentUseravatar())),

                        InkWell(
                                onTap: () async{
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfileTap()), // Replace EditProfileScreen with your actual widget/screen class
                                  );
                                  setState(() {
                                    
                                  });

                                },
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: primaryColor,
                                  child: Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: white,
                                  ),
                                ),
                              )
                            ,
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                       getCurrentUsername(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: primaryColor),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(0.0,2.0, 5.0, 10.0),
                      child: Text(
                         getCurrentUserbio(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: primaryColor),
                    )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Contribution",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: primaryColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                const Icon(Unicons.resources,
                                    size: 22, color: secondaryColor),
                                const SizedBox(height: 5),
                                Text('0',
                                    style:
                                        Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)),
                              ],
                            ),
                            const SizedBox(
                                width:
                                    20), // Adjust the width for the space between icons
                            Column(
                              children: [
                                const Icon(Icons.help,
                                    size: 22, color: secondaryColor),
                                const SizedBox(height: 5),
                                Text('0',
                                    style:
                                        Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)),
                              ],
                            ),
                            const SizedBox(
                                width:
                                    20), // Adjust the width for the space between icons
                            Column(
                              children: [
                                const Icon(Icons.school,
                                    size: 22, color: secondaryColor),
                                const SizedBox(height: 5),
                                Text('0',
                                    style:
                                        Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Posts",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: secondaryColor),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          FutureBuilder<List<PostModel>>(
  future: Profile.getUserAllPosts(userid: getCurrentUserId()),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Display a loading indicator
      return Text('0',style:Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor));
    } else if (snapshot.hasError) {
      // Display an error message
      return Text('0',style:Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor));
    } else {
      int postLen = snapshot.data!.length;
      
    return Text(
    '$postLen',
  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor),
);


    }
  },
),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Groups",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: secondaryColor),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              getnumallgroups().toString(),
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "created groups",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!.copyWith(color: secondaryColor),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              getnumgroups().toString(),
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
       Container(
  color: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Column(
    children: [
      CustomBinaryOption(
        textLeft: "Posts",
        textRight: "Collections",
        onOptionChanged: (bool isLeft) {
          setState(() {
            lr = isLeft;
          });
        },
      ),
      lr
          ? GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(
                5,
                (index) {
                  return const CustomCollectionItemWidget();
                },
              ),
            )
          : FutureBuilder<List<PostModel>>(
              future: Profile.getUserAllPosts(userid: getCurrentUserId()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Display an error message
                  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 80.0,
        child: Text(
          "No Posts",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: white)
        ),
        backgroundColor: secondaryColor, // Adjust color as needed
      ),
      const SizedBox(height: 10),
      // Add a good icon of an avatar here
      Icon(Icons.sentiment_satisfied, size: 50, color: primaryColor),
    ],
  );
                } else {
                  List<PostModel> posts = snapshot.data!;
                  int postlen = posts.length;

 
  return GridView.count(
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    shrinkWrap: true,
    children: List.generate(
      postlen,
      (index) {

        return CustomPostItemWidget(
          postUrl: posts[index].imageUrl!,
          id: getCurrentgroupid(),
          postid: posts[index].id!,
        );
      },
    ),
  );
}

                
              },
            ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }
}
