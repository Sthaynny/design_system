import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/ds_colors.dart';

abstract class DSSystemOverlayStyle {
  static const dark = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: DSColors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static const light = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static const statusBarLight = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: DSColors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
