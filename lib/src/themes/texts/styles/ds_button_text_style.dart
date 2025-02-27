import 'package:flutter/material.dart';

import '../utils/ds_font_weights.theme.dart';
import 'ds_text_style.dart';

/// A Design System's [TextStyle] primarily used by buttons.
///
/// This style's font variant is $fs-16-p1.
class DSButtonTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-16-p1 font variant.
  const DSButtonTextStyle({
    required super.color,
    super.overflow,
    super.fontStyle,
    super.height = 1.5,
  }) : super(
          fontSize: 16.0,
          fontWeight: DSFontWeights.bold,
        );
}
