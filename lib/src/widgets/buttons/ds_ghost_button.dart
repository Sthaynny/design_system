import 'package:design_system/src/widgets/buttons/ds_secondary_button.dart';
import 'package:flutter/material.dart';

/// A Design System's [ButtonStyleButton] primarily used by call to action.
class DSGhostButton extends DSSecondaryButton {
  /// Creates a Design System's [ButtonStyleButton] with ghost style.
  DSGhostButton({
    required super.onPressed,
    super.key,
    super.leadingIcon,
    super.label,
    super.trailingIcon,
    super.isEnabled,
    super.isLoading,
    super.autoSize,
    super.contentAlignment,
    super.foregroundColor,
    super.borderColor,
  }) : super(
          backgroundColor: Colors.transparent,
        );
}
