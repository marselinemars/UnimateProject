import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils/app_imports.dart';

class ActionWidget extends StatelessWidget {
  final String action;

  const ActionWidget(this.action, {super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height * 0.45;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: -width * 0.15,
            top: -height * 0.2,
            child: Container(
              width: width * 0.9,
              height: height * 0.95,
              decoration: const ShapeDecoration(
                color: secondaryColor,
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            right: -width * 0.2,
            top: -height * 0.15,
            child: Container(
              width: width * 0.7,
              height: height * 0.8,
              decoration: const ShapeDecoration(
                color: primaryColor,
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: width * 0.04,
            top: height * 0.1,
            child: SizedBox(
              width: height * 0.10,
              height: height * 0.10,
              child: IconButton(
                icon: Icon(
                  color: white,
                  Unicons.left_open_big,
                  size: height * 0.10,
                  weight: 150,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Positioned(
            left: width * 0.07,
            top: height * 0.3,
            child: SizedBox(
              width: width * 0.6,
              height: height * 0.4,
              child: Text(
                action,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getSubmitButton(
    String type, dynamic formKey, double w, void Function() function) {
  return Container(
    width: w,
    height: 50.0,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [primaryColor, secondaryColor], // Add your gradient colors here
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: TextButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          function();
        }
      },
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    ),
  );
}

class InputFieldWidget extends StatefulWidget {
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final bool isConfirmation;

  const InputFieldWidget({
    Key? key,
    required this.keyboardType,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.isConfirmation = false,
  }) : super(key: key);

  @override
  _InputFieldWidgetState createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText && widget.obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: greyWhite,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          borderSide: BorderSide(color: secondaryColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        hintText: widget.hintText,
        hintStyle: hintTextstyle,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon:
                    Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field cannot be empty';
        }

        if (widget.keyboardType == TextInputType.emailAddress) {
          final RegExp emailRegex =
              RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

          if (emailRegex.hasMatch(value)) {
            return null;
          }
          return 'Invalid Email';
        }

        if (widget.obscureText && !widget.isConfirmation) {
          final RegExp uppercaseRegex = RegExp(r'[A-Z]');
          final RegExp lowercaseRegex = RegExp(r'[a-z]');
          final RegExp digitRegex = RegExp(r'[0-9]');
          String password = value;

          if (uppercaseRegex.hasMatch(value) &&
              lowercaseRegex.hasMatch(value) &&
              digitRegex.hasMatch(value) &&
              (password.length >= 8)) {
            return null;
          }

          return '''Password must:
            - Be at least 8 characters long
            - Contain at least one uppercase letter
            - Contain at least one lowercase letter
            - Contain at least one digit''';
        }

        return null; // For other text fields without specific validation
      },
    );
  }
}

class AvatarPicker extends StatefulWidget {
  final void Function(File? image)? onImageSelected; // Callback function

  const AvatarPicker({Key? key, this.onImageSelected}) : super(key: key);

  @override
  _AvatarPickerState createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      if (widget.onImageSelected != null) {
        widget.onImageSelected!(_image); // Send the image file to the parent widget
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          backgroundColor: greylblue,
          radius: 80.0,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        Positioned(
          bottom: 5.0,
          right: 7.0,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: primaryColor,
            onPressed: _pickImage,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}