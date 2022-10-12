import 'package:flutter/widgets.dart';

class Styling {
  static const breakpointSM = 640;
  static const breakpointLD = 768;
  static const breakpointLG = 1024;
  static const breakpointXL = 1280;

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > breakpointLG;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > breakpointSM;
  }
}
