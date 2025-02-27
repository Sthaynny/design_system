import 'package:flutter/material.dart';

import '../../utils/ds_utils.dart';

/// A Design System's [AnimatedSize] that animates widgets whenever the given child's size changes.
class DSAnimatedSize extends AnimatedSize {
  /// Creates a Design System's [AnimatedSize].
  const DSAnimatedSize({
    super.key,
    super.child,
  }) : super(
          alignment: Alignment.topCenter,
          curve: Curves.linearToEaseOut,
          duration: DSUtils.defaultAnimationDuration,
          clipBehavior: Clip.hardEdge,
        );
}
