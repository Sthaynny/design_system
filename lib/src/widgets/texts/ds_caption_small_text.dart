import '../../themes/texts/styles/ds_caption_small_text_style.dart';
import 'ds_text.dart';

/// A Design System's [Text] primarily used by small subtitles and descriptions.
///
/// Sets [DSCaptionSmallTextStyle] as [style] default value. This style's font variant is $fs-12-p3.
class DSCaptionSmallText extends DSText {
  /// Creates a Design System's [Text] with $fs-12-p3 font variant.
  DSCaptionSmallText(
    super.text, {
    super.key,
    super.fontWeight,
    super.fontStyle,
    super.color,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
    super.isSelectable,
    super.height = 1.66,
  }) : super(
          style: DSCaptionSmallTextStyle(
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            overflow: overflow,
            height: height,
          ),
        );

  DSCaptionSmallText.rich(
    super.textSpan, {
    super.key,
    super.fontWeight,
    super.fontStyle,
    super.color,
    super.linkColor,
    super.overflow,
    super.textAlign,
    super.maxLines,
    super.shouldLinkify,
    super.isSelectable,
    super.height = 1.66,
  }) : super.rich(
          style: DSCaptionSmallTextStyle(
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            color: color,
            overflow: overflow,
            height: height,
          ),
        );
}
