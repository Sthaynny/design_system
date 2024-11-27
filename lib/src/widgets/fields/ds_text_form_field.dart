import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/colors/ds_colors.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.dart';
import '../../themes/texts/styles/ds_caption_text_style.dart';
import '../../themes/texts/utils/ds_font_weights.theme.dart';
import '../texts/ds_caption_small_text.dart';

class DSTextFormField extends StatefulWidget {
  const DSTextFormField({
    super.key,
    required this.textInputType,
    this.onChanged,
    this.controller,
    this.hintText,
    this.labelText,
    this.isEnabled = true,
    this.errorText,
    this.inputFormatters,
  });

  final TextInputType textInputType;
  final void Function(String term)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool isEnabled;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<DSTextFormField> createState() => _DSTextFormFieldState();
}

class _DSTextFormFieldState extends State<DSTextFormField> {
  final ValueNotifier<Color> _borderColor =
      ValueNotifier(DSColors.gray.shade100);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      _borderColor.value = _color();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _borderColor.value = _color();

    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: _borderColor,
          builder: (_, value, __) => Container(
            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 4.0, 6.0),
            decoration: BoxDecoration(
              color: widget.isEnabled
                  ? DSColors.gray.shade200
                  : DSColors.gray.shade50,
              border: Border.all(color: value),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              keyboardType: widget.textInputType,
              focusNode: _focusNode,
              controller: widget.controller,
              onChanged: widget.onChanged,
              style: DSBodyTextStyle(
                color: widget.isEnabled
                    ? DSColors.neutralDarkCity
                    : DSColors.gray.shade50,
              ),
              autofocus: false,
              enabled: widget.isEnabled,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                fillColor: widget.isEnabled
                    ? DSColors.gray.shade200
                    : DSColors.gray.shade50,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                labelText: widget.labelText,
                labelStyle: DSCaptionTextStyle(
                  fontWeight: DSFontWeights.bold,
                  color: widget.isEnabled
                      ? DSColors.neutralMediumCloud
                      : DSColors.gray.shade50,
                ),
                filled: true,
                hintText: widget.hintText ?? widget.labelText,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintStyle: DSBodyTextStyle(
                  color: DSColors.gray.shade300,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.errorText != null,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                const Icon(
                  DSIcons.error_solid,
                  color: DSColors.error,
                ),
                const SizedBox(width: 6.0),
                DSCaptionSmallText(
                  widget.errorText,
                  color: DSColors.error,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _color() {
    if (widget.errorText != null) {
      return DSColors.error;
    } else if (_focusNode.hasFocus) {
      return DSColors.primary.shade800;
    } else if (widget.isEnabled) {
      return DSColors.neutralMediumWave;
    } else {
      return DSColors.gray.shade100;
    }
  }
}
