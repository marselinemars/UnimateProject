import '../../services/user_service.dart';
import 'widgets.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_imports.dart';

// Define a custom Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() {
    return LoginFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool showProgressBar = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const ActionWidget("Welcome Back"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: height * 0.05,
                  ),
                  InputFieldWidget(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    obscureText: false,
                    controller: emailController,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InputFieldWidget(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'Password',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: const Text(
                          "FORGOT PASSWORD ?",
                          style: noCode,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  if (showProgressBar) const CircularProgressIndicator(),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  getSubmitButton("LOGIN", _formKey, width, () {
                    actionHandleLoginButton();
                  }),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  InkWell(
                    child: const Text(
                      "Don't have account? SIGN UP",
                      style: promptText,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  void actionHandleLoginButton() async {
    showProgressBar = true;
    errorMessage = '';
    print('just started the login ');
    setState(() {});
    print('just called the login service');

    String result = await UserAuthentication.loginUser({
      "email": emailController.text,
      "password": passwordController.text,
    });

    print('login call returned  ');

    if (result != 'success') {
      errorMessage = result;
      showProgressBar = false;
      setState(() {});
    } else {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    }
  }
}
