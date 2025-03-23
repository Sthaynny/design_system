import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SampleInputShowcase extends StatefulWidget {
  const SampleInputShowcase({super.key});

  @override
  State<SampleInputShowcase> createState() => _SampleInputShowcaseState();
}

class _SampleInputShowcaseState extends State<SampleInputShowcase> {
  final controller = TextEditingController();
  final items = ['Item 1', 'Item 2', 'Item 3'];
  final ValueNotifier valueNotifier = ValueNotifier<String?>(null);
  final ValueNotifier valueAutoSelectNotifier = ValueNotifier<String?>(null);
  final List<String> suggestions = [
    'Flutter',
    'Dart',
    'Firebase',
    'Android',
    'iOS',
    'React Native',
    'Kotlin',
    'Swift',
  ];

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

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
            label: 'Name',
          ),
          const DSTextFormField(
            textInputType: TextInputType.name,
            label: 'Name',
            isEnabled: false,
          ),
          const DSTextField(
            textInputType: TextInputType.name,
            hint: 'Name',
          ),
          const DSTextField(
            textInputType: TextInputType.name,
            hint: 'Name',
            isEnabled: false,
          ),
          ValueListenableBuilder(
            valueListenable: valueAutoSelectNotifier,
            builder: (context, value, child) => DSSelectTextInput<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return suggestions.where((option) => option
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (String selection) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selecionado: $selection')),
                );
              },
              // fieldViewBuilder:
              //     (context, controller, focusNode, onFieldSubmitted) {
              //   return DSTextField(
              //     controller: controller,
              //     focusNode: focusNode,
              //     hint: "Digite algo",
              //   );
              // },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, child) => DSSelectInput<String>(
                items: items
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                value: value,
                onChanged: (value) => valueNotifier.value = value),
          ),
          DsInputDatePicker(
            formatDate: (p0) => p0.formatDateToPtBr,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: DsInputDatePicker.range(),
          ),
          DSDateFormField(
            label: const Text('Date of birth'),
            onChanged: print,
            description:
                const Text('Your date of birth is used to calculate your age.'),
            validator: (v) {
              if (v == null) {
                return 'A date of birth is required.';
              }
              return null;
            },
          ),
          DsDateRangeFormField(
            label: const Text('Range of dates'),
            onChanged: print,
            description: const Text(
                'Select the range of dates you want to search between.'),
            validator: (v) {
              if (v == null) return 'A range of dates is required.';
              if (v.start == null) {
                return 'The start date is required.';
              }
              if (v.end == null) return 'The end date is required.';

              return null;
            },
          ),
        ],
      ),
    );
  }
}
