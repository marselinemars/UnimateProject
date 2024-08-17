import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';
import '../../widgets/comment_card.dart';

class CommentPageSpecialty extends StatefulWidget {
  const CommentPageSpecialty({super.key});

  @override
  _CommentPageSpecialtyState createState() => _CommentPageSpecialtyState();
}

class _CommentPageSpecialtyState extends State<CommentPageSpecialty> {

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Scaffold(
        body: Text("empty")
      ),
    );
  }
}
