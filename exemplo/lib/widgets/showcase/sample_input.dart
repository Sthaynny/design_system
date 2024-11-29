import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SampleInputShowcase extends StatelessWidget {
  SampleInputShowcase({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Wrap(
        runSpacing: 8.0,
        children: [
          DSSearchInput(
            onClear: () {},
            onSearch: (_) {},
          ),
          const DSTextFormField(
            textInputType: TextInputType.name,
            labelText: 'Name',
          ),
          DSSelectInput(
            controller: controller,
            textInputType: TextInputType.name,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
