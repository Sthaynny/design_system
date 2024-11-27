import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_icon_button.dart';

class DSAttachmentButton extends DSIconButton {
  DSAttachmentButton({
    super.key,
    required super.onPressed,
    super.isLoading,
  }) : super(
          icon: Icon(
            DSIcons.attach_outline,
            color: DSColors.gray.shade500,
          ),
        );
}
