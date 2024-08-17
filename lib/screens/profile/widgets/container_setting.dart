import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

class ContainerSetting extends StatefulWidget {
  const ContainerSetting({Key? key, required this.name, required this.icon}) : super(key: key);

  final String name;
  final IconData icon;

  @override
  State<ContainerSetting> createState() => _ContainerSettingState();
}

class _ContainerSettingState extends State<ContainerSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0,left:5),
      height: 50,
      width: 300, // Match the width with the screen
      decoration: BoxDecoration(
        color: gray.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(widget.name,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                // Handle button tap here
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: gray.withOpacity(0.3), // Gray transparent circle
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
