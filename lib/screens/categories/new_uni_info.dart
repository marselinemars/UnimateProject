import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../core/utils/app_imports.dart';
import '../widgets/app_bar.dart';
import '../../services/university_service.dart';

class NewUniForm extends StatefulWidget {
  const NewUniForm({super.key});

  @override
  _NewUniFormState createState() => _NewUniFormState();
}

class _NewUniFormState extends State<NewUniForm> {
  final Map<String, String> formData = {};
  List<XFile> galleryImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniAppBar(appTitle: 'University Information Form '),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount:
              universityInfoSections.length + 4, // Additional inputs for images
          itemBuilder: (context, index) {
            if (index == universityInfoSections.length + 1) {
              // Input for the main picture
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Main Picture',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: primaryColor),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      XFile? image = await _pickImage();
                      if (image != null) {
                        formData['Main Picture'] = image.path;
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey.withOpacity(0.3),
                      child: formData['Main Picture'] != null
                          ? Image.file(File(formData['Main Picture']!))
                          : const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            } else if (index == universityInfoSections.length + 2) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logo Picture',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: primaryColor),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      XFile? image = await _pickImage();
                      if (image != null) {
                        formData['Logo Picture'] = image.path;
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey.withOpacity(0.3),
                      child: formData['Logo Picture'] != null
                          ? Image.file(File(formData['Logo Picture']!))
                          : const Icon(Icons.add),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            } else if (index == universityInfoSections.length + 3) {
              // Section for additional pictures
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Pictures',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: primaryColor),
                  ),
                  const SizedBox(height: 8),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: galleryImages.length +
                        1, // Additional item for the add button
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, galleryIndex) {
                      if (galleryIndex == galleryImages.length) {
                        // Add button for additional pictures
                        return InkWell(
                          onTap: () async {
                            XFile? image = await _pickImage();
                            if (image != null) {
                              galleryImages.add(image);
                              setState(() {});
                            }
                          },
                          child: Container(
                            color: Colors.grey.withOpacity(0.3),
                            child: const Icon(Icons.add),
                          ),
                        );
                      } else {
                        // Display existing gallery images
                        return Image.file(
                            File(galleryImages[galleryIndex].path),
                            fit: BoxFit.cover);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              );
            } else if (index == universityInfoSections.length) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: primaryColor),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    maxLines: null,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: primaryColor),
                    decoration: InputDecoration(
                      labelText: "Latitude",
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
                    onChanged: (value) {
                      formData['latitude'] = value;
                    },
                  ),
                  //
                  const SizedBox(height: 8),
                  TextFormField(
                    maxLines: null,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: primaryColor),
                    decoration: InputDecoration(
                      labelText: "Longitude",
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
                    onChanged: (value) {
                      formData['longitude'] = value;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              );
            } else {
              // Form fields for other sections
              final section = universityInfoSections[index];
              final title = section['title'];
              final desc = section['desc'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: primaryColor)),
                  const SizedBox(height: 8),
                  TextFormField(
                    maxLines: null,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: primaryColor),
                    decoration: InputDecoration(
                      labelText: desc,
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
                    onChanged: (value) {
                      formData[title] = value;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backcolor,
        onPressed: () {
          _submitFormData();
        },
        child: const Icon(
          Icons.save,
          color: secondaryColor,
        ),
      ),
    );
  }

  Future<XFile?> _pickImage() async {
    final picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<void> _submitFormData() async {
    try {
      // Prepare image data
      List<File> imageFiles = [];
      Map<String, File> distinguishedImages = {};

      // Use the correct keys for main and logo pictures
      if (formData.containsKey('Main Picture')) {
        distinguishedImages['main_picture'] = File(formData['Main Picture']!);
      }
      if (formData.containsKey('Logo Picture')) {
        distinguishedImages['logo_picture'] = File(formData['Logo Picture']!);
      }
      for (var galleryImage in galleryImages) {
        imageFiles.add(File(galleryImage.path));
      }

      String responseMessage = await UniversityService.submitUniversityData(
          formData, distinguishedImages, imageFiles);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(responseMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to submit data: $e')));
    }

    // Optionally navigate back or reset the form
    // Navigator.pop(context);
  }
}
