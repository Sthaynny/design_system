import 'package:design_system/src/themes/decotation/utils/ds_border.dart';
import 'package:flutter/material.dart';

export 'utils/ds_border.dart';

@immutable
class DSDecoration {
  const DSDecoration({
    this.merge = true,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.secondaryBorder,
    this.secondaryFocusedBorder,
    this.secondaryErrorBorder,
    this.labelStyle,
    this.errorLabelStyle,
    this.errorStyle,
    this.descriptionStyle,
    this.labelPadding,
    this.descriptionPadding,
    this.errorPadding,
    this.fallbackToBorder,
    this.color,
    this.image,
    this.shadows,
    this.gradient,
    this.backgroundBlendMode,
    this.shape,
    this.hasError,
    this.fallbackToLabelStyle,
    this.disableSecondaryBorder,
  });

  static const DSDecoration none = DSDecoration(
    merge: false,
    border: DSBorder.none,
    focusedBorder: DSBorder.none,
    errorBorder: DSBorder.none,
    secondaryBorder: DSBorder.none,
    secondaryFocusedBorder: DSBorder.none,
    secondaryErrorBorder: DSBorder.none,
  );

  final bool merge;
  final TextStyle? labelStyle;
  final TextStyle? errorLabelStyle;
  final DSBorder? border;
  final DSBorder? focusedBorder;
  final DSBorder? errorBorder;
  final DSBorder? secondaryBorder;
  final DSBorder? secondaryFocusedBorder;
  final DSBorder? secondaryErrorBorder;
  final TextStyle? errorStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsets? labelPadding;
  final EdgeInsets? descriptionPadding;
  final EdgeInsets? errorPadding;
  final Color? color;
  final DecorationImage? image;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;
  final BlendMode? backgroundBlendMode;
  final BoxShape? shape;
  final bool? hasError;
  final bool? disableSecondaryBorder;

  /// Se deve recorrer ao [border] se nenhum [focusedBorder] ou [errorBorder]
  /// for fornecido, padrão é true.
  ///
  /// Isso também afeta o [secondaryBorder] com as mesmas condições.
  final bool? fallbackToBorder;

  /// Se deve recorrer ao [labelStyle] se nenhum [errorLabelStyle] for
  /// fornecido, padrão é true.
  final bool? fallbackToLabelStyle;

  static DSDecoration? lerp(
    DSDecoration? a,
    DSDecoration? b,
    double t,
  ) {
    if (a == null && b == null) return null;
    return DSDecoration(
      border: DSBorder.lerp(a?.border, b?.border, t),
      focusedBorder: DSBorder.lerp(a?.focusedBorder, b?.focusedBorder, t),
      errorBorder: DSBorder.lerp(a?.errorBorder, b?.errorBorder, t),
      secondaryBorder: DSBorder.lerp(a?.secondaryBorder, b?.secondaryBorder, t),
      secondaryFocusedBorder: DSBorder.lerp(
        a?.secondaryFocusedBorder,
        b?.secondaryFocusedBorder,
        t,
      ),
      secondaryErrorBorder:
          DSBorder.lerp(a?.secondaryErrorBorder, b?.secondaryErrorBorder, t),
      labelStyle: TextStyle.lerp(a?.labelStyle, b?.labelStyle, t),
      errorLabelStyle:
          TextStyle.lerp(a?.errorLabelStyle, b?.errorLabelStyle, t),
      errorStyle: TextStyle.lerp(a?.errorStyle, b?.errorStyle, t),
      descriptionStyle:
          TextStyle.lerp(a?.descriptionStyle, b?.descriptionStyle, t),
      labelPadding: EdgeInsets.lerp(a?.labelPadding, b?.labelPadding, t),
      descriptionPadding:
          EdgeInsets.lerp(a?.descriptionPadding, b?.descriptionPadding, t),
      errorPadding: EdgeInsets.lerp(a?.errorPadding, b?.errorPadding, t),
      fallbackToBorder: t < 0.5 ? a?.fallbackToBorder : b?.fallbackToBorder,
      color: Color.lerp(a?.color, b?.color, t),
      image: DecorationImage.lerp(a?.image, b?.image, t),
      shadows: BoxShadow.lerpList(a?.shadows, b?.shadows, t),
      gradient: Gradient.lerp(a?.gradient, b?.gradient, t),
      backgroundBlendMode:
          t < 0.5 ? a?.backgroundBlendMode : b?.backgroundBlendMode,
      shape: t < 0.5 ? a?.shape : b?.shape,
      hasError: t < 0.5 ? a?.hasError : b?.hasError,
      fallbackToLabelStyle:
          t < 0.5 ? a?.fallbackToLabelStyle : b?.fallbackToLabelStyle,
      disableSecondaryBorder:
          t < 0.5 ? a?.disableSecondaryBorder : b?.disableSecondaryBorder,
    );
  }

  DSDecoration mergeWith(DSDecoration? other) {
    if (other == null) return this;
    if (!other.merge) return other;
    return copyWith(
      border: border?.mergeWith(other.border) ?? other.border,
      focusedBorder:
          focusedBorder?.mergeWith(other.focusedBorder) ?? other.focusedBorder,
      errorBorder:
          errorBorder?.mergeWith(other.errorBorder) ?? other.errorBorder,
      secondaryBorder: secondaryBorder?.mergeWith(other.secondaryBorder) ??
          other.secondaryBorder,
      secondaryFocusedBorder:
          secondaryFocusedBorder?.mergeWith(other.secondaryFocusedBorder) ??
              other.secondaryFocusedBorder,
      secondaryErrorBorder:
          secondaryErrorBorder?.mergeWith(other.secondaryErrorBorder) ??
              other.secondaryErrorBorder,
      labelStyle: other.labelStyle ?? labelStyle,
      errorLabelStyle: other.errorLabelStyle ?? errorLabelStyle,
      errorStyle: other.errorStyle ?? errorStyle,
      descriptionStyle: other.descriptionStyle ?? descriptionStyle,
      labelPadding: other.labelPadding ?? labelPadding,
      descriptionPadding: other.descriptionPadding ?? descriptionPadding,
      errorPadding: other.errorPadding ?? errorPadding,
      fallbackToBorder: other.fallbackToBorder ?? fallbackToBorder,
      color: other.color ?? color,
      shape: other.shape ?? shape,
      backgroundBlendMode: other.backgroundBlendMode ?? backgroundBlendMode,
      shadows: other.shadows ?? shadows,
      gradient: other.gradient ?? gradient,
      image: other.image ?? image,
      hasError: other.hasError ?? hasError,
      fallbackToLabelStyle: other.fallbackToLabelStyle ?? fallbackToLabelStyle,
      disableSecondaryBorder:
          other.disableSecondaryBorder ?? disableSecondaryBorder,
    );
  }

  DSDecoration copyWith({
    DSBorder? border,
    DSBorder? focusedBorder,
    DSBorder? errorBorder,
    DSBorder? secondaryBorder,
    DSBorder? secondaryFocusedBorder,
    DSBorder? secondaryErrorBorder,
    TextStyle? labelStyle,
    TextStyle? errorLabelStyle,
    TextStyle? errorStyle,
    TextStyle? descriptionStyle,
    EdgeInsets? labelPadding,
    EdgeInsets? descriptionPadding,
    EdgeInsets? errorPadding,
    bool? fallbackToBorder,
    Color? color,
    BoxShape? shape,
    BlendMode? backgroundBlendMode,
    List<BoxShadow>? shadows,
    Gradient? gradient,
    DecorationImage? image,
    bool? hasError,
    bool? fallbackToLabelStyle,
    bool? disableSecondaryBorder,
  }) {
    return DSDecoration(
      border: border ?? this.border,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      errorBorder: errorBorder ?? this.errorBorder,
      secondaryBorder: secondaryBorder ?? this.secondaryBorder,
      secondaryFocusedBorder:
          secondaryFocusedBorder ?? this.secondaryFocusedBorder,
      secondaryErrorBorder: secondaryErrorBorder ?? this.secondaryErrorBorder,
      labelStyle: labelStyle ?? this.labelStyle,
      errorLabelStyle: errorLabelStyle ?? this.errorLabelStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      labelPadding: labelPadding ?? this.labelPadding,
      descriptionPadding: descriptionPadding ?? this.descriptionPadding,
      errorPadding: errorPadding ?? this.errorPadding,
      fallbackToBorder: fallbackToBorder ?? this.fallbackToBorder,
      color: color ?? this.color,
      shape: shape ?? this.shape,
      backgroundBlendMode: backgroundBlendMode ?? this.backgroundBlendMode,
      shadows: shadows ?? this.shadows,
      gradient: gradient ?? this.gradient,
      image: image ?? this.image,
      hasError: hasError ?? this.hasError,
      fallbackToLabelStyle: fallbackToLabelStyle ?? this.fallbackToLabelStyle,
      disableSecondaryBorder:
          disableSecondaryBorder ?? this.disableSecondaryBorder,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DSDecoration &&
        other.border == border &&
        other.focusedBorder == focusedBorder &&
        other.errorBorder == errorBorder &&
        other.secondaryBorder == secondaryBorder &&
        other.secondaryFocusedBorder == secondaryFocusedBorder &&
        other.secondaryErrorBorder == secondaryErrorBorder &&
        other.labelStyle == labelStyle &&
        other.errorLabelStyle == errorLabelStyle &&
        other.errorStyle == errorStyle &&
        other.descriptionStyle == descriptionStyle &&
        other.labelPadding == labelPadding &&
        other.descriptionPadding == descriptionPadding &&
        other.errorPadding == errorPadding &&
        other.fallbackToBorder == fallbackToBorder &&
        other.color == color &&
        other.shape == shape &&
        other.backgroundBlendMode == backgroundBlendMode &&
        other.shadows == shadows &&
        other.gradient == gradient &&
        other.image == image &&
        other.hasError == hasError &&
        other.fallbackToLabelStyle == fallbackToLabelStyle &&
        other.disableSecondaryBorder == disableSecondaryBorder;
  }

  @override
  int get hashCode =>
      border.hashCode ^
      focusedBorder.hashCode ^
      errorBorder.hashCode ^
      secondaryBorder.hashCode ^
      secondaryFocusedBorder.hashCode ^
      secondaryErrorBorder.hashCode ^
      labelStyle.hashCode ^
      errorLabelStyle.hashCode ^
      errorStyle.hashCode ^
      descriptionStyle.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      fallbackToBorder.hashCode ^
      color.hashCode ^
      shape.hashCode ^
      backgroundBlendMode.hashCode ^
      shadows.hashCode ^
      gradient.hashCode ^
      image.hashCode ^
      hasError.hashCode ^
      fallbackToLabelStyle.hashCode ^
      disableSecondaryBorder.hashCode;

  @override
  String toString() {
    return '''DSDecoration(border: $border, focusedBorder: $focusedBorder, errorBorder: $errorBorder, secondaryBorder: $secondaryBorder, secondaryFocusedBorder: $secondaryFocusedBorder, secondaryErrorBorder: $secondaryErrorBorder, labelStyle: $labelStyle, errorLabelStyle: $errorLabelStyle, errorStyle: $errorStyle, descriptionStyle: $descriptionStyle, labelPadding: $labelPadding, descriptionPadding: $descriptionPadding, errorPadding: $errorPadding, fallbackToBorder: $fallbackToBorder, color: $color, image: $image, shadows: $shadows, gradient: $gradient, backgroundBlendMode: $backgroundBlendMode, shape: $shape, hasError: $hasError, fallbackToLabelStyle: $fallbackToLabelStyle, disableSecondaryBorder: $disableSecondaryBorder)''';
  }
}

class ShadDecorator extends StatelessWidget {
  const ShadDecorator({
    super.key,
    this.child,
    this.decoration,
    this.focused = false,
  });

  /// O filho a ser decorado.
  final Widget? child;

  /// A decoração a ser aplicada ao filho.
  final DSDecoration? decoration;

  /// Se o filho está em foco, padrão é false.
  final bool focused;

  @override
  Widget build(BuildContext context) {
    const theme = DSDecoration();

    final effectiveDecoration = theme.mergeWith(decoration);

    final effectiveFallbackToBorder =
        effectiveDecoration.fallbackToBorder ?? true;

    final effectiveDisableSecondaryBorder =
        effectiveDecoration.disableSecondaryBorder ??
            theme.disableSecondaryBorder;

    final hasError = effectiveDecoration.hasError ?? false;

    final fallbackBorder = switch (focused) {
      true => effectiveDecoration.focusedBorder,
      false => effectiveDecoration.border,
    };

    var border = switch (hasError) {
      true => effectiveDecoration.errorBorder,
      false => fallbackBorder,
    };

    if (effectiveFallbackToBorder && border == null) {
      border = fallbackBorder ?? effectiveDecoration.border;
    }

    final fallbackSecondaryBorder = switch (focused) {
      true => effectiveDecoration.secondaryFocusedBorder,
      false => effectiveDecoration.secondaryBorder,
    };

    var secondaryBorder = switch (hasError) {
      true => effectiveDecoration.secondaryErrorBorder,
      false => fallbackSecondaryBorder,
    };

    if (effectiveFallbackToBorder && secondaryBorder == null) {
      secondaryBorder =
          fallbackSecondaryBorder ?? effectiveDecoration.secondaryBorder;
    }

    Widget decorated = Container(
      decoration: BoxDecoration(
        border: true == border?.hasBorder ? border?.toBorder() : null,
        borderRadius: effectiveDecoration.shape == BoxShape.circle
            ? null
            : border?.radius,
        color: effectiveDecoration.color,
        shape: effectiveDecoration.shape ?? BoxShape.rectangle,
        backgroundBlendMode: effectiveDecoration.backgroundBlendMode,
        boxShadow: effectiveDecoration.shadows,
        gradient: effectiveDecoration.gradient,
        image: effectiveDecoration.image,
      ),
      padding: border?.padding,
      child: child,
    );

    if (secondaryBorder != null && !(effectiveDisableSecondaryBorder ?? true)) {
      decorated = Container(
        decoration: BoxDecoration(
          border: secondaryBorder.hasBorder ? secondaryBorder.toBorder() : null,
          borderRadius: secondaryBorder.radius,
        ),
        padding: secondaryBorder.padding,
        child: decorated,
      );
    }

    return decorated;
  }
}
