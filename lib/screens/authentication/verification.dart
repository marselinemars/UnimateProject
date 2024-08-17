import 'widgets.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_imports.dart';

// Define a custom Form widget.
class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() {
    return VerificaitionState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class VerificaitionState extends State<Verification> {
  TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        const ActionWidget("Verification"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: greylblue,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  width: width,
                  height: height * 0.1,
                  child: const Center(
                      child: Text(
                    "Check your email for the code",
                    style: verificationText,
                    softWrap: true,
                  )),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                InputFieldWidget(
                  keyboardType: TextInputType.number,
                  hintText: 'Type Verification Code',
                  obscureText: false,
                  controller: codeController,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                InkWell(
                  child: const Text(
                    "Don't receive the code",
                    style: noCode,
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                getSubmitButton("Verify", _formKey, width, () {
                  Navigator.pushNamed(context, '/login');
                }),
                SizedBox(
                  height: height * 0.1,
                ),

                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          ),
        )
      ],
    )));
  }
}
