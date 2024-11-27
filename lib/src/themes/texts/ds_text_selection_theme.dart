import 'package:flutter/material.dart';

import '../colors/ds_colors.dart';

class DSTextSelectionThemeData extends TextSelectionThemeData {
  DSTextSelectionThemeData()
      : super(
          selectionColor: DSColors.system.withOpacity(0.5),
          selectionHandleColor: DSColors.system,
        );
}
