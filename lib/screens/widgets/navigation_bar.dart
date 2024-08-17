import 'package:flutter/material.dart';
import '../../../core/utils/app_imports.dart';

class UnavigationBar extends StatelessWidget {
  const UnavigationBar({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 18, top: 16, bottom: 12),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(color: gray.withOpacity(0.3), spreadRadius: 0.5, blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(Unicons.home, 'Home', 0),
          _buildNavItem(Unicons.groups, 'Groups', 1),
          _buildNavItem(Unicons.categories, 'Categories', 2),
          _buildNavItem(Unicons.resources, 'Resources', 3),
          _buildNavItem(Unicons.profile, 'Profile', 4),
        ],
      ), 
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected? backcolor : Colors.transparent,
          borderRadius: BorderRadius.circular(50)
        ),
        child: Row(
          children: [
            Icon(icon, size: isSelected ? 16 : 20, color: isSelected ? secondaryColor: primaryColor,),
            const SizedBox(width: 10,),
            if (isSelected)
            Text(label, style: const TextStyle(fontSize: 14, color: secondaryColor),)
          ],
        ),
      )
    );
  }
}

