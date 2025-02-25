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
    this.inputFormatters,
    this.validator,
  });

  final TextInputType textInputType;
  final void Function(String term)? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool isEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  State<DSTextFormField> createState() => _DSTextFormFieldState();
}

class _DSTextFormFieldState extends State<DSTextFormField> {
  final ValueNotifier<Color> _borderColor =
      ValueNotifier(DSColors.gray.shade100);
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isError = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      _borderColor.value = _color();
    });
  }

  @override
  void dispose() {
    _isError.dispose();
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
            decoration: BoxDecoration(
              color: widget.isEnabled
                  ? DSColors.gray.shade50
                  : DSColors.gray.shade200,
              border: Border.all(color: value),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              keyboardType: widget.textInputType,
              focusNode: _focusNode,
              controller: widget.controller,
              onChanged: widget.onChanged,
              validator: (value) {
                final result = widget.validator?.call(value);
                _isError.value = result != null;
                return result;
              },
              style: DSBodyTextStyle(
                color: widget.isEnabled
                    ? DSColors.primary.shade900
                    : DSColors.gray.shade50,
              ),
              autofocus: false,
              enabled: widget.isEnabled,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                fillColor: widget.isEnabled
                    ? DSColors.gray.shade50
                    : DSColors.gray.shade300,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                labelText: widget.labelText,
                labelStyle: DSCaptionTextStyle(
                  fontWeight: DSFontWeights.bold,
                  color: widget.isEnabled
                      ? DSColors.primary.shade800
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
        ValueListenableBuilder(
          valueListenable: _isError,
          builder: (__, isError, _) => Visibility(
            visible: isError,
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
                    widget.validator?.call(widget.controller?.text ?? '') ?? '',
                    color: DSColors.error,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _color() {
    if (_isError.value) {
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
