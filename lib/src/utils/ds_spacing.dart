import 'package:flutter/material.dart';

enum DSSpacing {
  /// Extra small spacing: 2
  xxxs(2),

  /// Extra small spacing: 4
  xxs(4),

  /// Extra small spacing: 8
  xs(8),

  /// Small spacing: 12
  sm(12),

  /// Medium spacing: 16
  md(16),

  /// Large spacing: 24
  lg(24),

  /// Extra large spacing: 32
  xl(32),

  /// Extra extra large spacing: 40
  xxl(40),

  /// Extra extra extra large spacing: 48
  xxxl(48),

  /// Extra extra extra large spacing: 56
  xxxxl(56),

  /// Giga large spacing: 64
  gl(64);

  const DSSpacing(this.value);
  final double value;
}

extension DSSpacingExtension on DSSpacing {
  SizedBox get x => SizedBox(width: value);
  SizedBox get y => SizedBox(height: value);
}
