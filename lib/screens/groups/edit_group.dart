import 'package:flutter/material.dart';
import '../../core/utils/app_imports.dart';
import 'package:unimate/screens/widgets/custom_botton.dart';
import 'package:unimate/services/Group_service.dart';
import 'package:unimate/screens/homescreen/widgets/custom_choice_chips.dart';
import 'package:unimate/screens/homescreen/widgets/custom_dropdown.dart';
import 'dart:io'; 
import 'package:image_picker/image_picker.dart';
class EditGroupTap extends StatefulWidget {
  const EditGroupTap({
    Key? key,
  }) : super(key: key);

  @override
  _EditGroupTapState createState() => _EditGroupTapState();
}

class _EditGroupTapState extends State<EditGroupTap> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
   List<String> selectedTags = [];
   File? pickedImageFile;
   String? selectedYear;
     bool showProgressBar = false;
     String errorMessage = '';
     List<String> years = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
  ];
  String? selectedSpecialty;
  String?  groupId;
  String groupname='';
  String bio='';
  String url='';
   
  List<String> specialties = [
    'MI',
    'Math',
    'Physics',
    'Data Mining',
    'Electronics',
    'Mechanic'
  ];

List<String> tags = ['Math', 'physics', 'Ai', 'Data mining','Machine learning','Medecine'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Accessing ModalRoute.of(context) here is safe
    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Access userId and postId
    groupId = arguments['groupId'];
    groupname = arguments['groupname'];
    bio = arguments['bio'];
    url = arguments['url'];
    selectedSpecialty = arguments['specialty'];
    selectedYear = arguments['year'];
    selectedTags = arguments['tags'].split(',');

    // Initialize controllers with updated values
    groupNameController.text = groupname;
    bioController.text = bio;
    // ... other initializations ...
  }

  @override
  Widget build(BuildContext context) {

     
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Edit Group',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
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
                      colors: [primaryColor, secondaryColor],
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
                          Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
                            radius: 50,
                            backgroundImage: pickedImageFile != null
                         ? FileImage(pickedImageFile!)as ImageProvider<Object>? // Set background to picked image
                          : NetworkImage(url), // Fallback to default image
                          ),
      ],
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
                      child: buildTextField(groupNameController, "Group Name",groupname,1,20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  buildTextField(bioController, "Bio",bio,2,50),
                  const SizedBox(height: 30),
               
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("# Specialty", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor),),
                Text("# Year", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor),),
              ],
            ),
             const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
             
                CustomDropdown(
                  items: specialties, 
                  selectedItem: selectedSpecialty,
                  onChanged: (value) {
                    setState(() {
                      selectedSpecialty = value;
                    });
                  },
                ),
                CustomDropdown(
                  items: years, 
                  selectedItem: selectedYear,
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                )
              ],
            ),
               const SizedBox(
              height: 20,
            ),
                Text("Tags", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor),),
                     CustomChoiceChips(
              tags: tags, 
              selectedTags: selectedTags,
              onChanged: (newSelectedTags) {
                setState(() {
                  selectedTags = newSelectedTags;
                });
              },
            ),
            const SizedBox(height: 10),
if (showProgressBar) const CircularProgressIndicator(),
                 const SizedBox(height: 10),
                   CustomButton(
              height: 40,
              color:  gradiant ,
              textColor:  Colors.white ,
              onTap: () {
               actionHandleeditgroupButton() ;
              },
              text: "Edit Group",
            ),
            SizedBox(height:2,),
                
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 2,), 
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
        {groupname=updatedText;}
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
 
 void actionHandleeditgroupButton() async {
    showProgressBar = true;
    errorMessage = '';
    setState(() {

    });
     String TagsString = selectedTags.join(',');
    String result = await Group.Editgroup(
    data: {
      'name': groupNameController.text,
      'bio': bioController.text,
      'year': selectedYear,
      'specialty': selectedSpecialty,
      'tags':TagsString ,
      'groupid':groupId
      
    },
   avatarImage: pickedImageFile,
    );
    
    

     if (result !='success') {
      errorMessage = result;
      showProgressBar = false;
      setState(() {});
    } else {  
     Navigator.pop(context, {'groupId': groupId});
   
    }
  }
}
