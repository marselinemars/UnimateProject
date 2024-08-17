import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

class CustomBinaryOption extends StatefulWidget {
  const CustomBinaryOption({
    Key? key,
    this.textLeft = "Left",
    this.textRight = "Right",
    required this.onOptionChanged,
  }) : super(key: key);

  final String textLeft;
  final String textRight;
  final Function(bool isLeft) onOptionChanged;

  @override
  State<CustomBinaryOption> createState() => _CustomBinaryOptionState();
}

class _CustomBinaryOptionState extends State<CustomBinaryOption> {
  bool lr = false;
  void updateCustomBinaryOption(bool newValue) {
    setState(() {
      lr = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        color: Colors.white,
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  widget.onOptionChanged(false);
                  setState(() {
                    lr = false;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.textLeft,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: lr == false ? primaryColor : secondaryColor,
                          ),
                    ),
                    Container(
                      height: lr == false ? 3 : 1,
                      color: lr == false ? primaryColor : secondaryColor,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  widget.onOptionChanged(true);
                  setState(() {
                    lr = true;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.textRight,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: lr == true ? primaryColor : secondaryColor,
                          ),
                    ),
                    Container(
                      height: lr == true ? 3 : 1,
                      color: lr == true ? primaryColor : secondaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
