import 'package:flutter/material.dart';

import '../../enums/ds_input_container_shape.dart';
import '../../themes/colors/ds_colors.dart';
import '../../utils/ds_utils.dart';

class DSInputContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final bool isEnabled;
  final bool? hasFocus;
  final DSInputContainerShape shape;
  final bool hasError;

  const DSInputContainer({
    super.key,
    this.child,
    this.padding,
    this.hasFocus,
    this.isEnabled = true,
    this.shape = DSInputContainerShape.rectangle,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: DSUtils.defaultAnimationDuration,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                shape == DSInputContainerShape.rectangle ? 8.0 : 22.0,
              ),
            ),
            border: Border.all(
              width: 1.0,
              color: hasError
                  ? DSColors.error
                  : hasFocus ?? false
                      ? DSColors.primary
                      : isEnabled
                          ? DSColors.gray.shade300
                          : DSColors.gray.shade100,
            ),
            color: isEnabled ? DSColors.gray.shade200 : DSColors.gray.shade50,
          ),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 44.0,
            ),
            padding: padding,
            child: child,
          ),
        ),
      );
}
