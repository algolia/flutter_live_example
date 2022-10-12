import 'package:flutter/widgets.dart';

class Styling {
  static const breakpoint_sm = 640;
  static const breakpoint_md = 768;
  static const breakpoint_lg = 1024;
  static const breakpoint_xl = 1280;

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > breakpoint_lg;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > breakpoint_md;
  }
}
