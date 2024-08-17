import 'package:flutter/material.dart';
import 'package:unimate/core/utils/app_imports.dart';
import 'package:unimate/services/comman_services.dart';
import'../posts.dart';
class CustomPostItemWidget extends StatefulWidget {
  const CustomPostItemWidget({Key? key, required this.postUrl,required this.id, required this.postid}) : super(key: key);

  final String postUrl;
  final String id;
  final String postid;

  @override
  State<CustomPostItemWidget> createState() => _CustomPostItemWidgetState();
}

class _CustomPostItemWidgetState extends State<CustomPostItemWidget> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: 165,
      height: 200,
      child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Post image
    Container(
      alignment: Alignment.centerLeft,
      width: 165,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: primaryColor,
          width: 2.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostScreen(),
              settings: RouteSettings(
                arguments: {
                  'userId': getCurrentUserId(),
                  'postId': widget.postid, // replace with the actual postId value
                },
              ),
            ),
          );
          // Navigate to the post screen or handle the onTap as needed
        },
        child: widget.postUrl != ''
            ? Center(child:Image.network(
                widget.postUrl,
                fit: BoxFit.fill,
              ) ,)
            : Center(
              child: Icon(
                Icons.image_not_supported, // Replace with the desired icon
                size: 150,
                color: secondaryColor,
              )
              )
      ),
    ),
  ],
)

    );
  }
}
