import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DSSelectTextInput<T extends Object> extends Autocomplete<T> {
  DSSelectTextInput({
    super.key,
    required super.optionsBuilder,
    String? label,
    super.onSelected,
    super.optionsMaxHeight = 200.0,
    super.optionsViewBuilder,
    super.optionsViewOpenDirection = OptionsViewOpenDirection.down,
    super.initialValue,
  }) : super(fieldViewBuilder:
            (context, controller, focusNode, onFieldSubmitted) {
          return DSTextField(
            controller: controller,
            focusNode: focusNode,
            hint: 'Selecione um item',
          );
        });
}
