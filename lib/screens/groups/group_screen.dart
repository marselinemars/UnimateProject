import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimate/services/comman_services.dart';
import '../../../core/utils/app_imports.dart';
import 'package:unimate/screens/widgets/custom_botton.dart';
import '../widgets/post_card.dart';
import '../../services/post_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; 
import '../../services/Group_service.dart';
import 'package:unimate/models/post_model.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
     
  Future<List<PostModel>> _postsFuture = Future.value([]);
  File? _coverImage;
  String groupId='';
  int?notadmin;
  bool isJoined=false;
final ScrollController _scrollController = ScrollController();
 
  Future<void> _changeCoverPicture() async {
   final imagePicker = ImagePicker();
   final XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
     _coverImage = File(pickedImage.path);
    }

     await Group.addcoverimage(id:groupId , avatarImage:_coverImage);
     setState(() {
      
     });

  }
  @override
  void initState() {
    super.initState();
   
   
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _postsFuture = Group.getgroupAllPosts(groupid: groupId);
    });
  }
  @override
  Widget build(BuildContext context) {

      Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    groupId=arguments!['groupId'];
    notadmin=arguments!['notadmin'];
    Future<Map<String, Map<String, dynamic>>> fetchData() async {
  bool isAdmin = (notadmin==0);// Replace this with your logic to determine if the user is an admin or not.

  if (isAdmin) {
    return await Group.getmygroups();
  } else {
    return await Group.getSuggestedGroup();
  }
}

    _postsFuture = Group.getgroupAllPosts(groupid: groupId);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 360,
              width: double.infinity,
              child: Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: GestureDetector(
                      onLongPress: () {
                        if(notadmin==0){
                            showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Change the Cover Picture",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: primaryColor),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: secondaryColor),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    
                                    _changeCoverPicture();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Choose from Gallery",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: secondaryColor),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        }
                      
                      },
                      child: 
                        FutureBuilder<Map<String, Map<String, dynamic>>>(
                    future:fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Positioned(
                          top: 220,
                          left: 5,
                          child:  Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:AssetImage('assets/images/post3.jpg'),
                                  fit:BoxFit.cover,
                                  
                                ),
                              ),
                            )
                        );
                      } else if (snapshot.hasError) {

                        return Text('Error: ${snapshot.error}');

                      } else  {
                        Map<String, Map<String, dynamic>> groups = snapshot.data!;
                        if(groups[groupId]?["coverpic_url"]!='')
                        {return
                          Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(groups[groupId]?["coverpic_url"]),
                                  fit:BoxFit.cover,
                                  
                                ),
                              ),
                            );
                        }
                        else{
                          return  
                          Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:AssetImage('assets/images/post3.jpg'),
                                  fit:BoxFit.cover,
                                  
                                ),
                              ),
                            );
                        }
                      }
                      // Add a default return if none of the conditions are met
                     
                    },
                  ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 50,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Unicons.left_open_big,
                        size: 22,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  FutureBuilder<Map<String, Map<String, dynamic>>>(
                    future:fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Positioned(
  top: 220,
  left: 5,
  child: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: secondaryColor, // Set your desired background color
    ),
    child: CircleAvatar(
       backgroundColor: secondaryColor,
      radius: 70,
      child: Icon(Icons.group, size: 40, color: Colors.white), // Set your desired icon properties
    ),
  ),
);

                      } else if (snapshot.hasError) {

                        return Text('Error: ${snapshot.error}');

                      } else  {
                        Map<String, Map<String, dynamic>> groups = snapshot.data!;
                        return Positioned(
                          top: 220,
                          left: 5,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                NetworkImage(groups[groupId]?["url_image"] ?? ''),
                          ),
                        );
                      }
                      // Add a default return if none of the conditions are met
                     
                    },
                  ),
                ],
              ),
            ),
            FutureBuilder<Map<String, Map<String, dynamic>>>(
                    future:fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {

                        return Text('Error: ${snapshot.error}');

                      } else  {
                        Map<String, Map<String, dynamic>> groups = snapshot.data!;
                        
                        return  Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      groups[groupId]?["Name"] ?? "", // Add a null check if needed
      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: primaryColor),
    ),
    if (notadmin == 0)
      IconButton(
        icon: Icon(Icons.edit, color: primaryColor),
        onPressed: () async {
          await Navigator.pushNamed(context, '/edit_group', arguments: {
            'groupId': groupId,
            'groupname': groups[groupId]?["Name"],
            'bio': groups[groupId]?["Bio"],
            'url': groups[groupId]?["url_image"],
            'year': groups[groupId]?["year"],
            'specialty': groups[groupId]?["Specialty"],
            'tags': groups[groupId]?["Tags"],
          });
          setState(() {
            // Handle state update if needed
          });
        },
      ),
      if(notadmin==1)
      ElevatedButton(
  onPressed: () {
    if(isJoined==false){
      handlejoingroup();
    }
    
   
    // Handle join group action
  },
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(primaryColor,),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Set your desired border radius
      ),
    ),
  ),
  child: Text (isJoined ? "Joined" : "Join the group",
      style: TextStyle(color: Colors.white),)
)

  
  ],
),

      SizedBox(height: 20),
      Text(
        'Specialty: ${groups[groupId]?["Specialty"]}',
         style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)
      ),
      SizedBox(height: 10),
      Text(
        'Tags:${groups[groupId]?["Tags"]}',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)
      ),
      SizedBox(height: 10),
      Text(
        'Year: ${groups[groupId]?["year"]}',
         style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)
      ),
      SizedBox(height: 10),
      Center(child: Text(
        groups[groupId]?["Bio"],
 style:Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)
      ) ,),
     
      SizedBox(height: 20),
    
      Row(
        children: [
          Icon(Icons.group, color: primaryColor, size: 20),
          Text(
            '  ${groups[groupId]?["members"]} Members',
            style:Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)
            ),
          
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10), // Adjust the left padding
                child: CustomButton(
                  height: 40,
                  color: gradiant,
                  textColor: Colors.white,
                  onTap: () {
            
                  },
                  text: "Join chat",
                ),
              ),
            ),
        ],
      ),
      SizedBox(height: 20),
      Row(children: [
        CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(groups[groupId]?["url_image"]), // Replace with your circular photo
                    ),
                     SizedBox(width: 10),
        Text("Add a Post"),
        
        SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:secondaryColor.withOpacity(0.4) ,
                        ),
                        child: GestureDetector(
        onTap: () async{
          // Navigate to the new screen when the text is clicked
        await Navigator.pushNamed(context, '/newpost',arguments: {'groupid':groupId});
        setState(() {
          
        });
        },
        child: Center(
          child: Text(
            'Express Yourself...',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.blue),
          ),
        ),
      ),
                      ),
      ],)
      
   
    ],
  ),
);
                      }
                      // Add a default return if none of the conditions are met
                     
                    },
                  ),
              
               FutureBuilder<List<PostModel>>(
                    future: _postsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return  Container(); // Placeholder for loading state
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Error handling
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                       
                        return
                         Center(
                          child: Column(
                            children: [
                              const Text('No posts available' ,
                              ),
                              IconButton(
                                  onPressed: _refreshPosts,
                                  icon: const Icon(Icons.refresh))
                            ],
                          ),
                        ); // Placeholder for empty state
                      } else {
                       List<PostModel> posts = snapshot.data!;

                      // Build the ListView.builder
                      return ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostCard(post: snapshot.data![index]);
                        },
                      );
                        }
                    },
                  )
              
                
             
          ],
        ),
      ),
    );
  }
    void handlejoingroup() async {
  bool result = await Group.joingroup(groupId);
  
  if (result) {
    isJoined = true;
    Navigator.pop(context);
    
  }
}

  
}
