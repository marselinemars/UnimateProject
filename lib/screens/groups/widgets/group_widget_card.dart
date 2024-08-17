import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';
import '../../widgets/custom_botton.dart';

class GroupCard extends StatefulWidget {
  final String? specialty;
  final String? name;
  final String? url;
  final String? id;
  final int? join;


  const GroupCard({Key? key, this.specialty, this.name, this.url,required this.id,this.join})
      : super(key: key);

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  bool accept = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
  children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        widget.url ?? '',
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    ),
    const SizedBox(
      width: 15,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name ?? '',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: primaryColor),
        ),
        const SizedBox(height: 5),
        Text(
          widget.specialty ?? '',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: secondaryColor),
        ),
        const SizedBox(height: 10),
      ],
    ),
    Spacer(), // Added Spacer widget to push the next content to the right
    Container(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CustomButton(
          height: 40,
          color: gradiant,
          textColor: Colors.white,
          onTap: () async{
            await Navigator.pushNamed(
              context,
              '/group_overview',
               arguments: {'groupId': widget.id,
                 'notadmin': widget.join,} // Pass the groupId as an argument
            );
            setState(() {
              
            });
          },
          text: "Join",
        ),
      ),
    ),
  ],
),

      ),
    );
  }
}
