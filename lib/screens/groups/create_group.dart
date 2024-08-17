import 'package:flutter/material.dart';
import 'package:unimate/services/comman_services.dart';
import '../../core/utils/app_imports.dart';
import 'package:unimate/screens/widgets/custom_botton.dart';
import 'package:unimate/services/Group_service.dart';
import 'package:unimate/screens/homescreen/widgets/custom_choice_chips.dart';
import 'package:unimate/screens/homescreen/widgets/custom_dropdown.dart';
import 'dart:io'; 
import 'package:image_picker/image_picker.dart';
class CreateGroupTap extends StatefulWidget {
  const CreateGroupTap({
    Key? key,
  }) : super(key: key);

  @override
  _CreateGroupTapState createState() => _CreateGroupTapState();
}

class _CreateGroupTapState extends State<CreateGroupTap> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
   List<String> selectedTags = [];
   File?  pickedImageFile;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Create Group',
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
                          buildGroupIcon(),
                       InkWell(
                            onTap: () async {
                
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
                      child: buildTextField(groupNameController, "Group Name",20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  buildTextField(bioController, "Bio",50),
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

                 const SizedBox(height: 30),
                   CustomButton(
              height: 40,
              color:  gradiant ,
              textColor:  Colors.white ,
              onTap: () {
               actionHandleaddgroupButton() ;
              },
              text: "Create Group",
            ),
            SizedBox(height:2,),
                if (showProgressBar) const CircularProgressIndicator(),
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

  Widget buildTextField(TextEditingController controller, String label,int maxlength) {
    return TextField(
      controller: controller,
      maxLength: maxlength,
      style: const TextStyle(color:  primaryColor),
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

  Widget buildGroupIcon() {
    return const Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: secondaryColor,
          child: Icon(
            Icons.group,
            size: 40,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
  
 void actionHandleaddgroupButton() async {
    showProgressBar = true;
    errorMessage = '';
    setState(() {});
    String TagsString = selectedTags.join(',');
    String result = await Group.Addgroup(
    data: {
      'name': groupNameController.text,
      'bio': bioController.text,
      'year': selectedYear,
      'specialty': selectedSpecialty,
      'tags':TagsString,
      'adminid':getCurrentUserId()
    },
    avatarImage: pickedImageFile,
    );

    if (result == 'Network error') {
      errorMessage = result;
      showProgressBar = false;
      setState(() {});
    } else {
      String id =result;
      Navigator.pop(context);
      Navigator.pushNamed(context, '/group_overview',arguments: id,);
    }
  }
}
