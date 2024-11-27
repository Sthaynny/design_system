import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.dart';
import '../animations/ds_spinner_loading.dart';

class DSIconButton extends InkWell {
  DSIconButton({
    super.key,
    required void Function() onPressed,
    required Widget icon,
    final bool isLoading = false,
    final double size = 44.0,
  }) : super(
          onTap: isLoading ? null : onPressed,
          child: SizedBox.fromSize(
            size: Size(size, size),
            child: Center(
              child: isLoading
                  ? DSSpinnerLoading(
                      color: DSColors.primary,
                      size: 24,
                      lineWidth: 4.0,
                    )
                  : icon,
            ),
          ),
        );
}
