import 'package:flutter/material.dart';

import 'ds_text_style.dart';

/// A Design System's [TextStyle] primarily used by small subtitles and descriptions.
///
/// This style's font variant is $fs-12-p3.
class DSCaptionSmallTextStyle extends DSTextStyle {
  /// Creates a Design System's [TextStyle] with $fs-12-p3 font variant.
  const DSCaptionSmallTextStyle({
    super.fontWeight,
    super.fontStyle,
    super.color,
    super.overflow,
    super.height = 1.66,
  }) : super(
          fontSize: 12.0,
        );
}
