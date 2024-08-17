import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class CustomChoiceChips extends StatefulWidget {
  const CustomChoiceChips({super.key, required this.tags, required this.selectedTags, required this.onChanged});

  final List<String> tags;
  final List<String> selectedTags;
  final ValueChanged<List<String>>? onChanged;

  @override
  State<CustomChoiceChips> createState() => _CustomChoiceChipsState();
}

class _CustomChoiceChipsState extends State<CustomChoiceChips> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10,
        children: List.generate(
          widget.tags.length,
          (index) => ChoiceChip(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                    color: secondaryColor, width: 2, style: BorderStyle.solid)),
            backgroundColor: Colors.white,
            selectedColor: secondaryColor,
            labelStyle: const TextStyle(color: primaryColor),
            padding: const EdgeInsets.all(8),
            label: Text(widget.tags[index]),
            selected: widget.selectedTags.contains(widget.tags[index]),
            onSelected: (isSelected) {
              setState(() {
                if (isSelected) {
                  widget.selectedTags.add(widget.tags[index]);
                } else {
                  widget.selectedTags.remove(widget.tags[index]);
                }
              });
              if (widget.onChanged != null) {
                widget.onChanged!(widget.selectedTags);
              }
            },
          ),
        ),
      ),
    );
  }
}
