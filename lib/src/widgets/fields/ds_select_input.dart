import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DSSelectInput<T> extends DropdownButtonFormField<T> {
  DSSelectInput({
    super.key,
    required super.items,
    required super.onChanged,
    super.value,
    super.onTap,
    super.focusNode,
    super.alignment,
    super.isExpanded = true,
    super.autofocus = false,
    bool showSuffixIcon = true,
    super.validator,
    String? hintText,
  }) : super(
            icon: Visibility(
              visible: showSuffixIcon,
              child: Icon(
                DSIcons.arrow_down_outline.data,
                color: DSColors.neutralMediumCloud,
              ),
            ),
            decoration: InputDecoration(
              fillColor: DSColors.gray.shade200,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: DSSpacing.xs.value),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: DSColors.primary.shade800,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: DSColors.neutralMediumWave,
                  width: 1.0,
                ),
              ),
              filled: true,
              hintText: hintText,
              hintStyle: DSBodyTextStyle(
                color: DSColors.gray.shade300,
              ),
            ));
}
