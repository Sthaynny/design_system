
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension DSBorderSideToBorderSide on DSBorderSide {
  BorderSide toBorderSide() {
    if (width == null || width == 0) return BorderSide.none;
    return BorderSide(
      color: color ?? Colors.transparent,
      width: width ?? 1,
      style: style ?? BorderStyle.solid,
      strokeAlign: strokeAlign ?? BorderSide.strokeAlignInside,
    );
  }
}

extension DSBorderToBorder on DSBorder {
  Border toBorder() {
    return Border(
      top: top?.toBorderSide() ?? BorderSide.none,
      right: right?.toBorderSide() ?? BorderSide.none,
      bottom: bottom?.toBorderSide() ?? BorderSide.none,
      left: left?.toBorderSide() ?? BorderSide.none,
    );
  }
}

/// {@template DSBorder}
/// Um wrapper em volta da classe [Border] com uma combina o razo vel.
/// {@endtemplate}
class DSBorder {
  /// {@macro DSBorder}
  const DSBorder({
    this.merge = true,
    this.padding,
    this.radius,
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  /// Cria um border cujos lados s o todos iguais.
  const DSBorder.fromBorderSide(
    DSBorderSide side, {
    this.merge = true,
    this.padding,
    this.radius,
  })  : top = side,
        right = side,
        bottom = side,
        left = side;

  /// Cria um border com lados verticais e horizontais sim tricos.
  ///
  /// O argumento [vertical] aplica-se s bordas [left] e [right], e o
  /// argumento [horizontal] aplica-se s bordas [top] e [bottom].
  const DSBorder.symmetric({
    DSBorderSide? vertical,
    DSBorderSide? horizontal,
    this.merge = true,
    this.padding,
    this.radius,
  })  : left = vertical,
        top = horizontal,
        right = vertical,
        bottom = horizontal;

  /// Um border uniforme com todos os lados iguais.
  ///
  /// Os lados s o preenchidos com bordas negras solidas, uma p xel l gica de
  /// largura.
  factory DSBorder.all({
    bool merge = true,
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
    EdgeInsets? padding,
    BorderRadiusGeometry? radius,
  }) {
    final side = DSBorderSide(
      color: color,
      width: width,
      style: style,
      strokeAlign: strokeAlign,
    );
    return DSBorder.fromBorderSide(
      side,
      padding: padding,
      merge: merge,
      radius: radius,
    );
  }

  static DSBorder? lerp(DSBorder? a, DSBorder? b, double t) {
    if (identical(a, b)) return a;
    return DSBorder(
      merge: b?.merge ?? a?.merge ?? true,
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      radius: BorderRadiusGeometry.lerp(a?.radius, b?.radius, t),
      top: DSBorderSide.lerp(
        a?.top,
        b?.top,
        t,
      ),
      right: DSBorderSide.lerp(
        a?.right,
        b?.right,
        t,
      ),
      bottom: DSBorderSide.lerp(
        a?.bottom,
        b?.bottom,
        t,
      ),
      left: DSBorderSide.lerp(
        a?.left,
        b?.left,
        t,
      ),
    );
  }

  bool get hasBorder =>
      (top?.width ?? 0) != 0 ||
      (right?.width ?? 0) != 0 ||
      (bottom?.width ?? 0) != 0 ||
      (left?.width ?? 0) != 0;

  static const DSBorder none = DSBorder(merge: false);

  /// Creates a [DSBorder] that represents the addition of the two given
  /// [DSBorder]s.
  DSBorder mergeWith(DSBorder? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      top: top?.mergeWith(other.top) ?? other.top,
      right: right?.mergeWith(other.right) ?? other.right,
      bottom: bottom?.mergeWith(other.bottom) ?? other.bottom,
      left: left?.mergeWith(other.left) ?? other.left,
      padding: other.padding,
      radius: other.radius,
    );
  }

  DSBorder copyWith({
    EdgeInsets? padding,
    DSBorderSide? top,
    DSBorderSide? right,
    DSBorderSide? bottom,
    DSBorderSide? left,
    BorderRadiusGeometry? radius,
  }) {
    return DSBorder(
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
      left: left ?? this.left,
      padding: padding ?? this.padding,
      radius: radius ?? this.radius,
    );
  }

  /// Whether to merge with another border, defaults to true.
  final bool merge;

  /// The padding of the border, defaults to null.
  final EdgeInsets? padding;

  /// The border radius of the border, defaults to null.
  final BorderRadiusGeometry? radius;

  final DSBorderSide? top;

  /// The right side of this border.
  final DSBorderSide? right;

  final DSBorderSide? bottom;

  /// The left side of this border.
  final DSBorderSide? left;

  @override
  String toString() {
    return '''DSBorder(merge: $merge, padding: $padding, radius: $radius, top: $top, right: $right, bottom: $bottom, left: $left)''';
  }
}

/// Creates the side of a border.
@immutable
class DSBorderSide with Diagnosticable {
  /// Creates the side of a border.
  const DSBorderSide({
    this.merge = true,
    this.color,
    this.width,
    this.style,
    this.strokeAlign,
  }) : assert(width == null || width >= 0.0);

  /// Merges two border sides into one
  DSBorderSide mergeWith(DSBorderSide? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      color: other.color,
      width: other.width,
      style: other.style,
      strokeAlign: other.strokeAlign,
    );
  }

  /// Whether to merge the border side
  final bool merge;

  /// The color of this side of the border.
  final Color? color;

  /// The width of this side of the border, in logical pixels.
  ///
  /// Setting width to 0.0 will result in a hairline border. This means that
  /// the border will have the width of one physical pixel. Hairline
  /// rendering takes shortcuts when the path overlaps a pixel more than once.
  /// This means that it will render faster than otherwise, but it might
  /// double-hit pixels, giving it a slightly darker/lighter result.
  final double? width;

  /// The style of this side of the border.
  final BorderStyle? style;

  /// A hairline black border that is not rendered.
  static const DSBorderSide none = DSBorderSide(merge: false);

  /// The relative position of the stroke on a [DSBorderSide] in an
  /// [OutlinedBorder] or [Border].
  ///
  /// Values typically range from -1.0 ([BorderSide.strokeAlignInside], inside
  /// border, default) to 1.0 ([BorderSide.strokeAlignOutside], outside border),
  /// without any bound constraints (e.g., a value of -2.0 is not typical, but
  /// allowed).
  /// A value of 0 ([BorderSide.strokeAlignCenter]) will center the border on
  /// the edge of the widget.
  ///
  /// When set to [BorderSide.strokeAlignInside], the stroke is drawn completely
  /// inside
  /// the widget. For [BorderSide.strokeAlignCenter] and
  /// [BorderSide.strokeAlignOutside], a property
  /// such as [Container.clipBehavior] can be used in an outside widget to clip
  /// it. If [Container.decoration] has a border, the container may incorporate
  /// [width] as additional padding:
  /// - [BorderSide.strokeAlignInside] provides padding with full [width].
  /// - [BorderSide.strokeAlignCenter] provides padding with half [width].
  /// - [BorderSide.strokeAlignOutside] provides zero padding, as stroke is
  /// drawn entirely outside.
  ///
  /// This property is not honored by toPaint (because the [Paint] object
  /// cannot represent it); it is intended that classes that use
  /// [DSBorderSide] objects implement this property when painting borders by
  /// suitably inflating or deflating their regions.
  final double? strokeAlign;

  /// Creates a copy of this border but with the given fields replaced with the
  /// new values.
  DSBorderSide copyWith({
    bool? merge,
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return DSBorderSide(
      merge: merge ?? this.merge,
      color: color ?? this.color,
      width: width ?? this.width,
      style: style ?? this.style,
      strokeAlign: strokeAlign ?? this.strokeAlign,
    );
  }

  static DSBorderSide? lerp(DSBorderSide? a, DSBorderSide? b, double t) {
    if (identical(a, b)) return a;
    return DSBorderSide(
      merge: b?.merge ?? a?.merge ?? true,
      color: Color.lerp(a?.color, b?.color, t),
      width: lerpDouble(a?.width, b?.width, t),
      style: t < 0.5 ? a?.style : b?.style,
      strokeAlign: lerpDouble(a?.strokeAlign, b?.strokeAlign, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DSBorderSide &&
        other.merge == merge &&
        other.color == color &&
        other.width == width &&
        other.style == style &&
        other.strokeAlign == strokeAlign;
  }

  @override
  int get hashCode => Object.hash(merge, color, width, style, strokeAlign);

  @override
  String toStringShort() => 'DSBorderSide';

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<Color>(
          'color',
          color,
          defaultValue: const Color(0xFF000000),
        ),
      )
      ..add(
        DiagnosticsProperty<bool>(
          'merge',
          merge,
          defaultValue: true,
        ),
      );

    properties
      ..add(DoubleProperty('width', width, defaultValue: 1.0))
      ..add(
        DoubleProperty(
          'strokeAlign',
          strokeAlign,
          defaultValue: BorderSide.strokeAlignInside,
        ),
      )
      ..add(
        EnumProperty<BorderStyle>(
          'style',
          style,
          defaultValue: BorderStyle.solid,
        ),
      );
  }
}


