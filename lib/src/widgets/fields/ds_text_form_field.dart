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
    this.textInputType,
    this.onChanged,
    this.controller,
    this.hint,
    this.label,
    this.isEnabled = true,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
  });

  final TextInputType? textInputType;
  final void Function(String term)? onChanged;
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final bool isEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool obscureText;

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
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 6.0,
            ),
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
              obscureText: widget.obscureText,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                fillColor: widget.isEnabled
                    ? DSColors.gray.shade50
                    : DSColors.gray.shade200,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                labelText: widget.label,
                labelStyle: DSCaptionTextStyle(
                  fontWeight: DSFontWeights.bold,
                  color: widget.isEnabled
                      ? DSColors.primary.shade800
                      : DSColors.gray.shade300,
                ),
                filled: true,
                hintText: widget.hint ?? widget.label,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintStyle: DSBodyTextStyle(
                  color: DSColors.gray.shade300,
                ),
                error: const SizedBox(),
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
                  Icon(
                    DSIcons.error_solid.data,
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
