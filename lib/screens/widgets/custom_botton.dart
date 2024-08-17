import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTap,
    this.color,
    required this.text,
    this.colorBorder,
    this.textColor,
    this.height = 56,
    this.width = double.infinity,
    this.padding = 24,
    Key? key,
  }) : super(key: key);

  final String? text;
  final Function() onTap;
  final Gradient? color; // Updated to accept Gradient
  final Color? colorBorder;
  final Color? textColor;
  final double height;
  final double width;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: color ?? const LinearGradient(colors: [primaryColor, secondaryColor]), // Use the provided gradient or a default one
            borderRadius: BorderRadius.circular(30),
            border: colorBorder == null
                ? null
                : Border.all(color: colorBorder!, width: 2),
          ),
          child: Text(
            text!,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
