
import 'package:flutter/material.dart';
import 'package:unimate/services/comman_services.dart';
import 'package:unimate/services/profile_service.dart';
import '../../core/utils/app_imports.dart';
import 'package:unimate/screens/widgets/custom_botton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; 

class EditProfileTap extends StatefulWidget {
  const EditProfileTap({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileTapState createState() => _EditProfileTapState();
}

class _EditProfileTapState extends State<EditProfileTap> {
  
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File?  pickedImageFile;
  bool showProgressBar=false;
  String errorMessage = '';
   String username=getCurrentUsername();
   String bio=getCurrentUserbio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor, // Set the app bar color to primary
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: white), // Set the title text color to black
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: 70,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        secondaryColor
                      ], // Set the circle gradient colors
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                           CircleAvatar(
                            radius: 50,
                            backgroundImage: pickedImageFile != null
                         ? FileImage(pickedImageFile!)as ImageProvider<Object>? // Set background to picked image
                          : NetworkImage(getCurrentUseravatar()), // Fallback to default image
                          ),
                          InkWell(
                            onTap: () async {
                // Use ImagePicker to get an image from the device
               final imagePicker = ImagePicker();
               final XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

                 if (pickedImage != null) {
                    // Do something with the picked image, like uploading it
                    // For example, you can set the picked image to an Image widget
                      setState(() {
                      pickedImageFile = File(pickedImage.path);

                  });

      // Now you can use pickedImageFile to upload or display the image
    }
  },
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor:
                                  primaryColor, // Set the circle background color
                              child: Icon(
                                Icons.camera_alt,
                                size: 15,
                                color: white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        getCurrentUsername(),
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      
                      child: buildTextField(usernameController, "Username",username,1,20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  buildTextField(bioController, "Bio",bio,2,50),
                  const SizedBox(height: 30),
          
                       CustomButton(
              height: 40,
              color:  gradiant ,
              textColor:  Colors.white ,
              onTap: () {
                actionhandlesavebutton();
               //
              },
              text: "Save",
            ),
            if (showProgressBar) const CircularProgressIndicator(),
             if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
buildTextField(TextEditingController controller, String label, String text,int target,int maxLength) {
  // Set the initial text for the controller
  
  controller.text = text;

  return TextField(
    controller: controller,
    maxLength: maxLength,
    style: const TextStyle(color: primaryColor),
    onChanged: (updatedText) {
      // Update the controller text only if the updated text is not empty
      if (updatedText.isNotEmpty) {

        controller.text = updatedText;
        if(target==1)
        {username=updatedText;}
        if(target==2)
        {
          bio=updatedText;
        }
        
      }
    },
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: secondaryColor),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: secondaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 234, 231, 231),
    ),
  );
}


   void actionhandlesavebutton() async {
    showProgressBar = true;
    setState(() {});
    String result = await Profile.editprofile(
   data: {
  'name': usernameController.text,
  'bio': bioController.text,
  'userid': getCurrentUserId()
},

  avatarImage: pickedImageFile,
);

    if (result != 'success') {
      showProgressBar = false;
      errorMessage = result;

      setState(() {});
    } else {
      Navigator.pop(context);
      
    }

    }
}
