import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  String? selectedItem;
  final ValueChanged<String?>? onChanged;

  CustomDropdown({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 8, bottom: 8, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: secondaryColor, // Change this to your secondaryColor
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: DropdownButton<String>(
        menuMaxHeight: 200,
        borderRadius: BorderRadius.circular(8),
        value: widget.selectedItem,
        onChanged: (newValue) {
          setState(() {
            widget.selectedItem = newValue == 'Select' ? null : newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        items: [
          const DropdownMenuItem<String>(
            value: null,
            child: Text(
              'Select ', // Provide a default option
              style: TextStyle(color: primaryColor),
            ),
          ),
          ...widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                    color: Colors.black), // Change to your primaryColor
              ),
            );
          }).toList(),
        ],
        style:
            const TextStyle(color: Colors.black), // Change to your primaryColor
        icon: const Icon(Icons.arrow_drop_down),
        iconEnabledColor: Colors.black, // Change to your primaryColor
        iconDisabledColor: Colors.grey,
        underline: Container(),
        elevation: 0,
        isDense: true,
        dropdownColor: Colors.white,
      ),
    );
  }
}
