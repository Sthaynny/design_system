import 'package:flutter/material.dart';

import '../../enums/ds_button_shape.dart';
import '../../themes/colors/ds_colors.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_button.dart';

class DSSendButton extends DSButton {
  DSSendButton({
    super.key,
    super.onPressed,
    super.isEnabled = true,
    super.isLoading,
    Color? backgroundColor,
    Color? foregroundColor,
  }) : super(
          shape: DSButtonShape.rounded,
          leadingIcon: Icon(
            DSIcons.send_solid.data,
          ),
          backgroundColor: isEnabled
              ? (backgroundColor ?? DSColors.primary.shade800)
              : DSColors.gray.shade200,
          foregroundColor: isEnabled
              ? (foregroundColor ?? DSColors.gray.shade200)
              : DSColors.gray.shade300,
        );
}
