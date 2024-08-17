import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

class SpecialtyInfoSection extends StatelessWidget {
  const SpecialtyInfoSection(
      {super.key, required this.index, required this.info});

  final int index;
  final String info;

  @override
  Widget build(BuildContext context) {
    String sectiontitle = specialtyInfoSections[index]['title'] as String;
    double width = MediaQuery.of(context).size.width;

    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ExpansionTile(
        title: Text(sectiontitle),
        maintainState: true,
        textColor: secondaryColor,
        collapsedTextColor: primaryColor,
        iconColor:secondaryColor,
        collapsedIconColor:primaryColor,
        backgroundColor: backcolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        children: [
          Container(
            decoration: BoxDecoration(
                border: const Border(
                    top: BorderSide(
                        color:primaryColor , width: 2, style: BorderStyle.solid)),
                borderRadius: BorderRadius.circular(0)),
            width: width,
            padding: const EdgeInsets.all(15),
            child: Text(info, style: info_text),
          )
        ],
      ),
    );
  }
}
