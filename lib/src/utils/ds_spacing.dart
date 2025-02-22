import 'package:flutter/material.dart';

enum DSSpacing {
  xxxs(2),
  xxs(4),
  xs(8),
  sm(12),
  md(16),
  lg(24),
  xl(32),
  xxl(40),
  xxxl(64);

  const DSSpacing(this.value);
  final double value;
}

extension DSSpacingExtension on DSSpacing {
  SizedBox get x => SizedBox(width: value);
  SizedBox get y => SizedBox(height: value);
}
