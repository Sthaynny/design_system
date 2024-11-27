import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.dart';

class DSSearchInput extends StatelessWidget {
  const DSSearchInput({
    super.key,
    required this.onSearch,
    required this.onClear,
    this.focusNode,
    this.controller,
    this.showSuffixIcon = true,
    this.hintText,
    this.iconBackgroundColor,
    this.iconForegroundColor,
    this.enabled,
  });

  final void Function(String term) onSearch;
  final void Function() onClear;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool showSuffixIcon;
  final String? hintText;
  final Color? iconBackgroundColor;
  final Color? iconForegroundColor;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: TextField(
        enabled: enabled ?? true,
        focusNode: focusNode,
        controller: controller,
        onChanged: onSearch,
        style: const DSBodyTextStyle(color: DSColors.neutralDarkCity),
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: Visibility(
            visible: showSuffixIcon,
            child: IconButton(
              splashRadius: 1,
              onPressed: () => onClear(),
              icon: const Icon(
                DSIcons.error_solid,
                color: DSColors.neutralMediumCloud,
              ),
            ),
          ),
          fillColor: DSColors.gray.shade200,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 25.0,
            minHeight: 25.0,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? DSColors.gray.shade200,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Icon(
                DSIcons.search_outline,
                size: 21.0,
                color: iconForegroundColor ?? DSColors.primary.shade800,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: DSColors.primary.shade800,
              width: 1.0,
            ),
          ),
          disabledBorder: _getBorder(),
          enabledBorder: _getBorder(),
          filled: true,
          hintText: hintText,
          hintStyle: DSBodyTextStyle(
            color: DSColors.gray.shade300,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _getBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: DSColors.neutralMediumWave,
          width: 1.0,
        ),
      );
}
