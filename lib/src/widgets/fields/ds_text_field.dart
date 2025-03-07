import 'package:flutter/material.dart';

import '../../enums/ds_input_container_shape.dart';
import '../../themes/colors/ds_colors.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.dart';
import '../texts/ds_caption_small_text.dart';
import 'ds_input_container.dart';

class DSTextField extends StatefulWidget {
  const DSTextField({
    super.key,
    required this.hint,
    this.controller,
    this.onChanged,
    this.textInputAction = TextInputAction.send,
    this.onTap,
    this.onTapOutside,
    this.maxLines,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.focusNode,
    this.isEnabled = true,
    this.shape = DSInputContainerShape.rectangle,
    this.errorText,
    this.textInputType,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String hint;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final VoidCallback? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final FocusNode? focusNode;
  final bool isEnabled;
  final DSInputContainerShape shape;
  final String? errorText;
  final TextInputType? textInputType;
  final bool autofocus;

  @override
  State<DSTextField> createState() => _DSTextFieldState();
}

class _DSTextFieldState extends State<DSTextField> {
  final _scrollController = ScrollController();
  final hasFocusNofifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: hasFocusNofifier,
        builder: (context, value, child) => Focus(
          focusNode: widget.focusNode,
          onFocusChange: (hasFocus) => widget.focusNode?.nextFocus(),
          child: Column(
            children: [
              DSInputContainer(
                hasError: widget.errorText?.isNotEmpty ?? false,
                shape: widget.shape,
                hasFocus: hasFocusNofifier.value,
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 6.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 6.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTextField(),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.errorText?.isNotEmpty ?? false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                        Icon(
                        DSIcons.error_solid.data,
                        color: DSColors.error,
                      ),
                      const SizedBox(width: 6.0),
                      Flexible(
                        child: DSCaptionSmallText(
                          widget.errorText,
                          color: DSColors.error,
                          overflow: TextOverflow.visible,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildTextField() => Flexible(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100.0,
          ),
          child: TextField(
            autofocus: widget.autofocus,
            keyboardType: widget.textInputType,
            controller: widget.controller,
            scrollController: _scrollController,
            enabled: widget.isEnabled,
            obscureText: widget.obscureText,
            style: const DSBodyTextStyle(),
            cursorColor: DSColors.primary,
            cursorHeight: 20.0,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            onTapOutside: widget.onTapOutside,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: widget.hint,
              hintStyle: DSBodyTextStyle(
                color: DSColors.gray.shade300,
              ),
            ),
          ),
        ),
      );
}
