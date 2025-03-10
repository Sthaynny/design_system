import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SampleHeaderShowcase extends StatelessWidget {
  const SampleHeaderShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DSHeader(
          title: 'Blip Design System ',
          subtitle: 'Showcase',
          canPop: true,
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: DSPrimaryButton(onPressed: null, label: 'Teste'),
            )
          ],
        ),
        DSHeader(
          title: 'Design System ',
          subtitle: 'Showcase',
          customerName: 'Andre Rossi',
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.filter_alt_rounded,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
