import 'package:flutter/material.dart';
import '../../core/utils/app_imports.dart';
import '../widgets/app_bar.dart';

class NewSpecialtyForm extends StatefulWidget {
  const NewSpecialtyForm({super.key});

  @override
  _NewSpecialtyFormState createState() => _NewSpecialtyFormState();
}

class _NewSpecialtyFormState extends State<NewSpecialtyForm> {
  final Map<String, String> formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniAppBar(appTitle: 'Specialty Information Form '),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount:
              universityInfoSections.length, // Additional inputs for images
          itemBuilder: (context, index) {
            // Form fields for other sections
            final section = universityInfoSections[index];
            final title = section['title'];
            final desc = section['desc'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title!, style: Theme.of(context).textTheme.subtitle1!.copyWith(color: primaryColor)),
                const SizedBox(height: 8),
                TextFormField(
                  maxLines: null,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: primaryColor),
                  
                  decoration:  InputDecoration(
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
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backcolor,
        onPressed: () {
          // Print or use the form data and gallery images as needed
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.save,
          color: secondaryColor,
        ),
      ),
    );
  }
}
