import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SampleTextStyleShowcase extends StatelessWidget {
  const SampleTextStyleShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSHeadlineExtraLargeText(
          'Headline EXTRA LARGE Text',
        ),
        DSHeadlineLargeText(
          'Headline Large Text',
        ),
        DSHeadlineSmallText(
          'Headline Small Text',
        ),
        DSBodyText(
          'Body Text',
          // color: DSColors.extendRedsLipstick,
          decoration: TextDecoration.underline,
          // fontWeight: DSFontWeights.extraBold,
          overflow: TextOverflow.fade,
        ),
        DSButtonText(
          'Button Text',
          color: DSColors.neutralDarkCity,
        ),
        DSCaptionText(
          'Caption Large Text',
          // color: DSColors.extendRedsLipstick,
          // fontWeight: DSFontWeights.extraBold,
        ),
        DSCaptionSmallText(
          'Caption Small Text',
          // color: DSColors.extendRedsLipstick,
          // fontWeight: DSFontWeights.extraBold,
        ),
      ],
    );
  }
}
