import 'dart:io';

import '../../services/user_service.dart';
import 'widgets.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_imports.dart';

// Define a custom Form widget.
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() {
    return SignUpFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class SignUpFormState extends State<SignUpForm> {

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  bool showProgressBar = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        const ActionWidget("Create Account"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AvatarPicker(onImageSelected: _handleImageSelection,),
                SizedBox(height: height * 0.05,),
                InputFieldWidget(
                  keyboardType: TextInputType.name,
                  hintText: 'User name',
                  obscureText: false,
                  controller: userNameController,
                ),
                SizedBox(height: height * 0.02,),
                InputFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
                ),
                SizedBox(height: height * 0.02,),
                InputFieldWidget(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(height: height * 0.02,),
                InputFieldWidget(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Confirm password',
                  obscureText: true,
                  isConfirmation: true,
                  controller: confirmPasswordController,
                ),
                SizedBox(height: height * 0.02,),
                if (showProgressBar) const CircularProgressIndicator(),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                SizedBox(height: height * 0.02,), 
                getSubmitButton("Sign Up", _formKey, width, () {
                  actionHandleSignupButton();
                }),
                SizedBox(
                  height: height * 0.03,
                ),
                InkWell(
                  child: const Text(
                    "Already have account?  LOGIN",
                    style: promptText,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: height * 0.03,
                ),
              ],
            ),
          ),
        )
      ],
    )));
  }

  void _handleImageSelection(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  void actionHandleSignupButton() async {
    showProgressBar = true;
    errorMessage = '';
    setState(() {});

    String result = await UserAuthentication.signupUser(
    data: {
      'name': userNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'confirmPassword': confirmPasswordController.text,
    },
    avatarImage: _selectedImage,
    );

    if (result != 'success') {
      errorMessage = result;
      showProgressBar = false;
      setState(() {});
    } else {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/login');
    }
  }
}
