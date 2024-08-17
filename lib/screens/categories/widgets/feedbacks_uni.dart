import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

class CommentPageUni extends StatefulWidget {
  const CommentPageUni({super.key});

  @override
  _CommentPageUniState createState() => _CommentPageUniState();
}

class _CommentPageUniState extends State<CommentPageUni> {

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.7,
      child: Scaffold(
        backgroundColor: greyWhite,
        body: Text("Empty")
      ),
    );
  }
}
