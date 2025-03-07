import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.dart';
import '../../themes/icons/ds_icons.dart';
import 'ds_icon_button.dart';

class DSCustomRepliesIconButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isVisible;
  final bool isLoading;

  const DSCustomRepliesIconButton({
    super.key,
    required this.onPressed,
    this.isVisible = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) => Visibility(
        visible: isVisible,
        child: DSIconButton(
          isLoading: isLoading,
          onPressed: onPressed,
          icon: DSIcons.message_talk_outline,
          color: DSColors.gray.shade500,
        ),
      );
}
