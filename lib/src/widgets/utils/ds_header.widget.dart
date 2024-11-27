import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/colors/ds_colors.dart';
import '../../themes/system_overlay/ds_system_overlay.dart';
import '../../themes/texts/styles/ds_body_text_style.dart';
import '../../themes/texts/styles/ds_headline_small_text_style.dart';
import '../../themes/texts/styles/ds_text_style.dart';
import '../../utils/ds_utils.dart';
import '../../widgets/texts/ds_text.widget.dart';
import '../texts/ds_caption_text.widget.dart';
import 'ds_user_avatar.widget.dart';

class DSHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final String? customerName;
  final Uri? customerUri;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? bottomWidget;
  final bool? canPop;
  final void Function()? onBackButtonPressed;
  final DSTextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final double? elevation;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color borderColor;
  final bool showBorder;
  final bool visible;
  late final bool isBackgroundLight;

  DSHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.customerName,
    this.customerUri,
    this.actions,
    this.leading,
    this.canPop,
    this.onBackButtonPressed,
    this.titleTextStyle,
    this.elevation = 0.0,
    this.bottomWidget,
    this.onTap,
    this.backgroundColor,
    this.borderColor = DSColors.neutralMediumWave,
    this.showBorder = true,
    this.visible = true,
    final SystemUiOverlayStyle? systemUiOverlayStyle,
  }) : systemUiOverlayStyle =
            systemUiOverlayStyle ?? DSSystemOverlayStyle.dark {
    isBackgroundLight = _backgroundColor.computeLuminance() > 0.5;
  }

  Color get _backgroundColor => backgroundColor ?? DSColors.gray.shade200;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: DSUtils.defaultAnimationDuration,
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                    color: borderColor,
                  ),
                )
              : null,
        ),
        child: SafeArea(
          top: false,
          bottom: false,
          child: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            elevation: elevation,
            backgroundColor: Colors.transparent,
            shadowColor: DSColors.neutralMediumWave,
            bottom: bottomWidget != null
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: bottomWidget!,
                  )
                : null,
            actions: actions,
            titleSpacing: 0,
            leadingWidth: 40.0,
            leading: _buildLeading(context),
            title: _buildTitle(context),
            systemOverlayStyle: systemUiOverlayStyle,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56.0);

  Widget _buildTitle(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding:
          _canPop(context) ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
      leading: customerName != null || customerUri != null
          ? DSUserAvatar(
              text: customerName,
              uri: customerUri,
              radius: 20.0,
              textStyle: DSBodyTextStyle(
                color: isBackgroundLight
                    ? DSColors.gray.shade200
                    : DSColors.neutralDarkCity,
              ),
            )
          : null,
      title: DSText(
        title,
        style: titleTextStyle ??
            DSHeadlineSmallTextStyle(
              color: isBackgroundLight
                  ? DSColors.neutralDarkCity
                  : DSColors.gray.shade200,
            ),
      ),
      subtitle: subtitle != null
          ? DSCaptionText(
              subtitle!,
              color: isBackgroundLight
                  ? DSColors.neutralDarkCity
                  : DSColors.gray.shade200,
            )
          : null,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    return leading ??
        (_canPop(context)
            ? IconButton(
                splashRadius: 17,
                padding: EdgeInsets.zero,
                onPressed: visible
                    ? onBackButtonPressed ?? Navigator.of(context).pop
                    : null,
                iconSize: 28,
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: isBackgroundLight
                      ? DSColors.gray.shade500
                      : DSColors.gray.shade200,
                ),
              )
            : null);
  }

  bool _canPop(BuildContext context) =>
      onBackButtonPressed != null || (canPop ?? Navigator.of(context).canPop());
}
