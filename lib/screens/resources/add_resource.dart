import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:unimate/models/user_model.dart';
import 'package:unimate/services/user_service.dart';
import '../widgets/app_bar.dart';
import '../../services/resources_service.dart';
import 'dart:io';

class AddResourceForm extends StatefulWidget {
  @override
  _AddResourceFormState createState() => _AddResourceFormState();
}

class _AddResourceFormState extends State<AddResourceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String?> selectedAttachments = [];
  List<String?> selectedAttachmentPaths = [];
  String title = '';
  String specialty = '';
  String description = '';
  String errorMessage = '';
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniAppBar(appTitle: 'New Resource Form '),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                  onSaved: (value) => title = value!,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Specialty',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Specialty is required';
                    }
                    return null;
                  },
                  onSaved: (value) => specialty = value!,
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                  onSaved: (value) => description = value!,
                ),
                SizedBox(height: 16.0),
                Column(
                  children: List.generate(
                    selectedAttachments.length,
                    (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text(
                            selectedAttachments[index] == null
                                ? 'No file attached'
                                : 'File: ${selectedAttachments[index]}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              _removeAttachment(index);
                            },
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (selectedAttachments.isNotEmpty) SizedBox(height: 8.0),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _pickAttachment();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20.0),
                        ),
                        child: Icon(Icons.attach_file, color: Colors.white),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Add Attachment',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                      SizedBox(height: 30),
                      isUploading
                          ? CircularProgressIndicator(
                              color: Colors.blue,
                            )
                          : Container(),
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            errorMessage = '';
            isUploading = true;
          });
          bool success = await _submitForm();
          setState(() {
            isUploading = false;
          });
          if (success) {
            Navigator.of(context).pop();

            _showSuccessDialog(context);
          }
        },
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.save, color: Colors.white),
        heroTag:
            'saveButton', // Set a unique hero tag to avoid duplicate hero IDs
      ),
    );
  }

  void _pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      String fileName = result.files.single.path ?? '';
      setState(() {
        selectedAttachments.add(path.basename(fileName));
        selectedAttachmentPaths.add(fileName);
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      selectedAttachments.removeAt(index);
      selectedAttachmentPaths.removeAt(index);
    });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("resource is saved successfully!"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                print('pop me ');
                print('i am not getting poped ');
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      print('Title: $title');
      print('Specialty: $specialty');
      print('Description: $description');
      print('Attachments: $selectedAttachmentPaths');

      if (selectedAttachmentPaths.length == 0) {
        setState(() {
          errorMessage = 'provide attachments ';
        });

        return false;
      } else {
        UserModel? user = await UserAuthentication.getLoggedUser();
        String id = user!.id;

        await ResourceService.uploadResource({
          "title": title,
          "specialty": specialty,
          "description": description,
          "attachment_paths": selectedAttachmentPaths,
          "user_id": id,
        }, selectedAttachmentPaths.map((path) => File(path!)));
      }
    }

    print(errorMessage);
    return true;
  }
}
