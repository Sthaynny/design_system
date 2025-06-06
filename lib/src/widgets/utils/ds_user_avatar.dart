import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/src/utils/ds_utils.dart';
import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.dart';
import '../../themes/icons/ds_icons.dart';
import '../../themes/texts/styles/ds_body_text_style.dart';
import '../texts/ds_text.dart';

class DSUserAvatar extends StatelessWidget {
  final String? text;
  final Uri? uri;
  final double radius;
  final Color? backgroundColor;
  final TextStyle textStyle;

  static const _defaultTextStyle = DSBodyTextStyle(
    color: DSColors.neutralDarkCity,
    overflow: TextOverflow.clip,
  );

  DSUserAvatar({
    super.key,
    this.text,
    this.uri,
    this.radius = 25.0,
    this.backgroundColor,
    TextStyle textStyle = _defaultTextStyle,
  }) : textStyle = textStyle.copyWith(
          color: textStyle.color ?? _defaultTextStyle.color,
          overflow: _defaultTextStyle.overflow,
        );

  factory DSUserAvatar.secundary({
    Key? key,
    String? text,
    Uri? uri,
    double radius = 25.0,
    TextStyle? textStyle,
  }) =>
      DSUserAvatar(
        key: key,
        text: text,
        uri: uri,
        radius: radius,
        textStyle: textStyle?.copyWith(
              color: DSColors.secundary.shade300,
            ) ??
            _defaultTextStyle.copyWith(
              color: DSColors.secundary.shade300,
            ),
        backgroundColor: DSColors.primary.shade900,
      );

  @override
  Widget build(BuildContext context) => uri != null
      ? CachedNetworkImage(
          imageUrl: uri.toString(),
          imageBuilder: (_, image) => CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor ?? const Color(0xFF21CC79),
            backgroundImage: image,
          ),
          progressIndicatorBuilder: (_, __, downloadProgress) {
            final size = Size.fromRadius(radius);

            return SizedBox(
              height: size.height,
              width: size.width,
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                strokeWidth: 1,
              ),
            );
          },
          errorWidget: (_, __, ___) => _defaultUserIcon,
        )
      : _defaultUserIcon;

  String get _initials {
    String initials = '';

    if (text?.isNotEmpty ?? false) {
      initials = RegExp('${text!.split(' ').length >= 2 ? '\\b' : ''}[A-Za-z]')
          .allMatches(text!)
          .map((m) => m.group(0))
          .join()
          .toUpperCase();

      if (initials.isNotEmpty) {
        initials = initials.substring(0, initials.length >= 2 ? 2 : 1);
      }
    }

    return initials;
  }

  CircleAvatar get _defaultUserIcon => (text?.isNotEmpty ?? false)
      ? CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: _initials.isNotEmpty
                ? DSText(
                    _initials,
                    style: textStyle,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )
                : Icon(
                    DSIcons.user_default_outline.data,
                    color: DSColors.gray.shade200,
                    size: 20.0,
                  ),
          ),
        )
      : CircleAvatar(
          radius: radius,
          backgroundColor: backgroundColor,
          backgroundImage: const AssetImage(
            'assets/images/avatar-default.png',
            package: DSUtils.packageName,
          ),
        );
}
