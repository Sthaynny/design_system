import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.dart';
import 'ds_button.dart';

/// A Design System's [ButtonStyleButton] primarily used by secondary actions.
///
/// Set [isEnabled] to activate/deactivate this button's [onPressed] and change his style.
/// Set [isLoading] to override content with a loading animation. It also deactivates [onPressed].
class DSSecondaryButton extends DSButton {
  /// Creates a Design System's [ButtonStyleButton] with secondary style.
  DSSecondaryButton({
    required super.onPressed,
    super.key,
    super.leadingIcon,
    super.label,
    super.trailingIcon,
    super.isEnabled,
    super.isLoading,
    super.autoSize,
    super.contentAlignment,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
  }) : super(
          backgroundColor: backgroundColor ?? DSColors.gray.shade100,
          foregroundColor: foregroundColor ??
              (isEnabled ? DSColors.primary.shade800 : DSColors.gray.shade300),
          borderColor: borderColor ??
              (isEnabled ? DSColors.primary.shade800 : DSColors.gray.shade300),
        );
}
