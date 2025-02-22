import 'package:flutter/material.dart';

import '../colors/ds_colors.dart';

class DSTextSelectionThemeData extends TextSelectionThemeData {
  DSTextSelectionThemeData()
      : super(
          selectionColor: DSColors.system.withValues(alpha: 125),
          selectionHandleColor: DSColors.system,
        );
}
