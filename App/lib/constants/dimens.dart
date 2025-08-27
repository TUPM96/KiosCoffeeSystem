import 'package:flutter/material.dart';

class Dimens {
  Dimens._();

  //for all screens
  static const double horizontal_padding = 12.0;
  static const double vertical_padding = 12.0;

  static const Widget hSpaceTiny = SizedBox(width: 5.0);
  static const Widget hSpaceSmall = SizedBox(width: 13.0);
  static const Widget hSpaceRegular = SizedBox(width: 18.0);
  static const Widget hSpaceMedium = SizedBox(width: 25.0);
  static const Widget hSpaceLarge = SizedBox(width: 50.0);
  static const Widget vSpaceTiny = SizedBox(height: 5.0);
  static const Widget vSpaceSmall = SizedBox(height: 10.0);
  static const Widget vSpaceSemiRegular = SizedBox(height: 14.0);
  static const Widget vSpaceRegular = SizedBox(height: 18.0);
  static const Widget vSpaceMedium = SizedBox(height: 25.0);
  static const Widget vSpaceLarge = SizedBox(height: 50.0);

  static const double kLightLineHeight = 20;
  static const double kNormalLineHeight = 22;
  static const double kLargeLineHeight = 30;

// Screen Size helpers
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double screenHeightPercentage(BuildContext context,
          {double percentage = 1}) =>
      screenHeight(context) * percentage;

  double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
      screenWidth(context) * percentage;
}
