import '../../themes/texts/styles/ds_headline_small_text_style.dart';
import 'ds_text.dart';

/// A Design System's [Text] primarily used by small titles.
///
/// Sets [DSHeadlineSmallTextStyle] as [style] default value. This style's font variant is $fs-16-p1.
class DSHeadlineSmallText extends DSText {
  /// Creates a Design System's [Text] with $fs-16-p1 font variant.
  DSHeadlineSmallText(
    super.text, {
    super.key,
    super.color,
    super.linkColor,
    super.overflow,
    super.fontStyle,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
    super.isSelectable,
    super.height = 1.5,
  }) : super(
          style: DSHeadlineSmallTextStyle(
            color: color,
            overflow: overflow,
            fontStyle: fontStyle,
            height: height,
          ),
        );

  DSHeadlineSmallText.rich(
    super.textSpan, {
    super.key,
    super.color,
    super.linkColor,
    super.overflow,
    super.fontStyle,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
    super.isSelectable,
    super.height = 1.5,
  }) : super.rich(
          style: DSHeadlineSmallTextStyle(
            color: color,
            overflow: overflow,
            fontStyle: fontStyle,
            height: height,
          ),
        );
}
