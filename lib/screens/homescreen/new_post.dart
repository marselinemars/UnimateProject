import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimate/main.dart';
import 'package:unimate/screens/homescreen/widgets/custom_choice_chips.dart';
import 'package:unimate/screens/homescreen/widgets/custom_dropdown.dart';
import '../../../core/utils/app_imports.dart';
import '../../services/post_service.dart';
import '../widgets/app_bar.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> selectedTags = [];
  String? selectedUniversity;
  List<String> universities = [
    'University A',
    'University B',
    'University C',
    'University D',
    'University E',
    'University F'
  ];
  String? selectedYear;
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
  List<String> tags = ['Question', 'Tag1', 'Tag2', 'Tag3'];

  File? _pickedImage;
  String? groupId;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
   groupId=arguments["groupid"];
    return Scaffold(
      appBar: const UniAppBar(appTitle: "New Post"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: _pickedImage != null,
              child: Center(
                child: Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.95 * 9 / 16,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: gray,
                        image: _pickedImage != null
                            ? DecorationImage(
                                image: FileImage(_pickedImage!),
                                fit: BoxFit.fitWidth)
                            : null),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: secondaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _pickedImage = null;
                          });
                        },
                      ))
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Stack(children: [
                  TextField(
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: primaryColor),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Write something ...',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: backcolor2),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: primaryColor,
                          )),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 1.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Unicons.sound,
                                size: 20, color: primaryColor),
                            onPressed: () {},
                          ),
                          IconButton(
                              icon: const Icon(Unicons.image,
                                  size: 18, color: primaryColor),
                              onPressed: () async {
                                final pickedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  setState(() {
                                    _pickedImage = File(pickedImage.path);
                                  });
                                }
                              }),
                        ],
                      ))
                ]),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text("# Tags",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: primaryColor)),
              ],
            ),
            const SizedBox(height: 10),
            CustomChoiceChips(
              tags: tags,
              selectedTags: selectedTags,
              onChanged: (newSelectedTags) {
                setState(() {
                  selectedTags = newSelectedTags;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "# University",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: primaryColor),
                ),
                Text(
                  "# Specialty",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: primaryColor),
                ),
                Text(
                  "# Year",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomDropdown(
                  items: universities,
                  selectedItem: selectedUniversity,
                  onChanged: (value) {
                    setState(() {
                      selectedUniversity = value;
                    });
                  },
                ),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    actionHandlePostButton();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        secondaryColor), // Change background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        primaryColor), // Change font color
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                          color: primaryColor,
                          width: 1.0), // Change border color
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 30.0), // Adjust padding
                    ),
                  ),
                  child: const Text(
                    'Post',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void actionHandlePostButton() async {
    String userId = userController
        .userId.value; // Get user ID from your authentication system
    String content = _textEditingController.text;
    print("helooooo");
    print(groupId);
    String result = await PostService.addPost(
      data: {'userId': userId, 'content': content, 'universityTag': selectedUniversity, 'specialtyTag': selectedSpecialty, 'yearTag': selectedYear, 'tags': selectedTags,},
      postImage: _pickedImage,
      groupid: groupId, 
    );
    if (result == 'success') {
      // Handle success scenario
      Navigator.pop(context);
    } else {
      print(result);
    }
  }
}
