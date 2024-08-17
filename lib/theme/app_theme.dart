import 'package:flutter/material.dart';
import 'styles.dart';

class AppTheme {
  static ThemeData customTheme() {
    return ThemeData(
      textTheme:  TextTheme(
        titleLarge: MyTextStyles.headline1,
        titleMedium: MyTextStyles.headline2,
        titleSmall: MyTextStyles.headline3,
        bodyLarge: MyTextStyles.bodyText1,
        bodyMedium: MyTextStyles.bodyText2,
        bodySmall: MyTextStyles.subtitle1,
        labelSmall: MyTextStyles.labelSmall
      ),
    );
  }
}
