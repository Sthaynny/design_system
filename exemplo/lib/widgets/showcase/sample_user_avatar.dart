import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SampleUserAvatarShowcase extends StatelessWidget {
  const SampleUserAvatarShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          radius: 12.0,
          textStyle: const DSCaptionSmallTextStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          radius: 16.0,
          textStyle: const DSCaptionTextStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          radius: 12.0,
          textStyle: const DSBodyTextStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          textStyle: DSHeadlineLargeTextStyle(
            color: DSColors.primary,
          ),
          backgroundColor: DSColors.secundary,
        ),
        const SizedBox(
          height: 15,
        ),
        DSUserAvatar(
          text: "Adriano Chamon Tavares",
          radius: 40.0,
          textStyle: DSHeadlineExtraLargeTextStyle(
            color: DSColors.secundary.shade300,
          ),
          backgroundColor: DSColors.primary.shade900,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
