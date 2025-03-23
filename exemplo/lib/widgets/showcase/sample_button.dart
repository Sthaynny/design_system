import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SampleButtonShowcase extends StatelessWidget {
  const SampleButtonShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSPrimaryButton(
          onPressed: () => {},
          label: 'Primary Button',
          leadingIcon: const Icon(
            Icons.info_outline,
            size: 30,
          ),
          trailingIcon: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          // isEnabled: true,
          // isLoading: true,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DSPrimaryButton(
            onPressed: () => {},
            isEnabled: false,
            label: 'Primary Button disabled',
            leadingIcon: const Icon(
              Icons.info_outline,
              size: 30,
            ),
            trailingIcon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            // isEnabled: true,
            // isLoading: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: DSSecondaryButton(
            onPressed: () => {},
            label: 'Secondary Button',
            leadingIcon: const Icon(
              Icons.info_outline,
              size: 20,
            ),
            trailingIcon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: DSColors.secundary.shade500,
            ),
            // isEnabled: true,
            // isLoading: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: DSSecondaryButton(
            onPressed: () => {},
            isEnabled: false,
            label: 'Secondary Button disabled',
            leadingIcon: const Icon(
              Icons.info_outline,
              size: 20,
            ),
            trailingIcon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            // isEnabled: true,
            // isLoading: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: DSTertiaryButton(
            onPressed: () => {},
            label: 'Tertiary Button',
            leadingIcon: const Icon(
              Icons.info_outline,
              size: 20,
            ),
            trailingIcon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            // isEnabled: true,
            // isLoading: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: DSTertiaryButton(
            onPressed: () => {},
            isEnabled: false,
            label: 'Tertiary Button disabled',
            leadingIcon: const Icon(
              Icons.info_outline,
              size: 20,
            ),
            trailingIcon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            // isEnabled: true,
            // isLoading: true,
          ),
        ),
        Container(
          width: double.maxFinite,
          color: DSColors.secundary.shade100,
          padding: const EdgeInsets.only(top: 8.0, left: 100, right: 100),
          child: DSGhostButton(
            onPressed: () => {},
            label: 'GhostButton',
            leadingIcon: const Icon(
              Icons.info_outline,
              size: 20,
            ),
            trailingIcon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            // isEnabled: true,
            // isLoading: true,
          ),
        ),
        Container(
          width: double.maxFinite,
          color: DSColors.gray.shade50,
          padding: const EdgeInsets.only(top: 8.0, left: 100, right: 100),
          child: DSGhostButton(
            onPressed: () => {},
            isEnabled: false,
            label: 'GhostButton',
            leadingIcon: const Icon(
              Icons.info_outline,
              size: 20,
            ),
            trailingIcon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            // isEnabled: true,
            // isLoading: true,
          ),
        ),
      ],
    );
  }
}
