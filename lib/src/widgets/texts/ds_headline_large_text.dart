import '../../themes/texts/styles/ds_headline_large_text_style.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import 'ds_text.dart';

/// A Design System's [Text] primarily used by large titles.
///
/// Sets [DSHeadlineLargeTextStyle] as [style] default value. This style's font variant is $fs-20-h4.
class DSHeadlineLargeText extends DSText {
  /// Creates a Design System's [Text] with $fs-20-h4 font variant.
  DSHeadlineLargeText(
    super.text, {
    super.key,
    super.color,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.fontWeight = DSFontWeights.bold,
    super.fontStyle,
    super.shouldLinkify,
    super.isSelectable,
    super.height = 1.4,
  }) : super(
          style: DSHeadlineLargeTextStyle(
            color: color,
            overflow: overflow,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            height: height,
          ),
        );

  DSHeadlineLargeText.rich(
    super.textSpan, {
    super.key,
    super.color,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.fontWeight = DSFontWeights.bold,
    super.fontStyle,
    super.shouldLinkify,
    super.isSelectable,
    super.height = 1.4,
  }) : super.rich(
          style: DSHeadlineLargeTextStyle(
            color: color,
            overflow: overflow,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            height: height,
          ),
        );
}
