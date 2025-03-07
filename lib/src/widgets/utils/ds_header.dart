import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/colors/ds_colors.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/system_overlay/ds_system_overlay.dart';
import '../../themes/texts/styles/ds_headline_small_text_style.dart';
import '../../themes/texts/styles/ds_text_style.dart';
import '../../utils/ds_utils.dart';
import '../texts/ds_caption_text.dart';
import '../texts/ds_text.dart';
import 'ds_user_avatar.dart';

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
  final double? leadingWidth;
  final bool centerTitle;
  final Widget? customTitle;

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
    this.centerTitle = false,
    final SystemUiOverlayStyle? systemUiOverlayStyle,
    this.leadingWidth,
    this.customTitle,
  }) : systemUiOverlayStyle =
            systemUiOverlayStyle ?? DSSystemOverlayStyle.light {
    isBackgroundLight = _backgroundColor.computeLuminance() > 0.5;
  }

  factory DSHeader.customTitle({
    required Widget customTitle,
    String? subtitle,
    String? customerName,
    Uri? customerUri,
    List<Widget>? actions,
    Widget? leading,
    bool? canPop,
    void Function()? onBackButtonPressed,
    DSTextStyle? titleTextStyle,
    double? elevation = 0.0,
    Widget? bottomWidget,
    void Function()? onTap,
    Color? backgroundColor,
    Color borderColor = DSColors.neutralMediumWave,
    bool showBorder = true,
    bool visible = true,
    bool centerTitle = false,
    SystemUiOverlayStyle? systemUiOverlayStyle,
    double? leadingWidth,
  }) {
    return DSHeader(
      title: '',
      subtitle: subtitle,
      customerName: customerName,
      customerUri: customerUri,
      actions: actions,
      leading: leading,
      canPop: canPop,
      onBackButtonPressed: onBackButtonPressed,
      titleTextStyle: titleTextStyle,
      elevation: elevation,
      bottomWidget: bottomWidget,
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      showBorder: showBorder,
      visible: visible,
      centerTitle: centerTitle,
      systemUiOverlayStyle: systemUiOverlayStyle,
      leadingWidth: leadingWidth,
      customTitle: customTitle,
    );
  }

  Color get _backgroundColor => backgroundColor ?? DSColors.gray.shade100;
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
            centerTitle: centerTitle,
            automaticallyImplyLeading: false,
            elevation: elevation,
            backgroundColor: Colors.transparent,
            shadowColor: DSColors.primary.shade100.withAlpha(20),
            bottom: bottomWidget != null
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: bottomWidget!,
                  )
                : null,
            actions: actions,
            titleSpacing: 0,
            leadingWidth: leadingWidth ?? 40.0,
            leading: _buildLeading(context),
            title: customTitle ?? _buildTitle(context),
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
          ? DSUserAvatar.secundary(
              text: customerName,
              uri: customerUri,
              radius: 20.0,
            )
          : null,
      title: DSText(
        title,
        style: titleTextStyle ??
            DSHeadlineSmallTextStyle(
              color: isBackgroundLight
                  ? DSColors.primary.shade900
                  : DSColors.gray.shade200,
            ),
      ),
      subtitle: subtitle != null
          ? DSCaptionText(
              subtitle!,
              color: isBackgroundLight
                  ? DSColors.primary.shade700
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
                  DSIcons.arrow_left_outline.data,
                  color: isBackgroundLight
                      ? DSColors.gray.shade300
                      : DSColors.gray.shade200,
                ),
              )
            : null);
  }

  bool _canPop(BuildContext context) =>
      onBackButtonPressed != null || (canPop ?? Navigator.of(context).canPop());
}
