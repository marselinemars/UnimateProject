import 'package:flutter/material.dart';
import 'package:unimate/theme/colors.dart';
import 'package:unimate/theme/unicons_icons.dart';

class UniAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UniAppBar({super.key, required this.appTitle});

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: primaryColor,
      elevation: 1,
      leadingWidth: 50,
      title: Text(appTitle),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Unicons.left_open_big, size: 22,color: primaryColor,)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
