import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DSSnackBar extends SnackBar {
  DSSnackBar._({
    required String text,
    Color? textColor,
    Color? backgroundColor,
    super.action,
  }) : super(
          content: DSBodyText(
            text,
            color: textColor ?? DSColors.neutralDarkCity,
            maxLines: 3,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor ?? DSColors.primary,
        );

  factory DSSnackBar.error(
    String text, {
    SnackBarAction? action,
  }) =>
      DSSnackBar._(
        text: text,
        backgroundColor: DSColors.error,
        textColor: DSColors.white,
        action: action,
      );

  factory DSSnackBar.success(
    String text, {
    SnackBarAction? action,
  }) =>
      DSSnackBar._(
        text: text,
        backgroundColor: DSColors.success,
        textColor: DSColors.black,
        action: action,
      );
  factory DSSnackBar.warning(
    String text, {
    SnackBarAction? action,
  }) =>
      DSSnackBar._(
        text: text,
        backgroundColor: DSColors.warning,
        textColor: DSColors.primary,
        action: action,
      );
  factory DSSnackBar.info(
    String text, {
    SnackBarAction? action,
  }) =>
      DSSnackBar._(text: text, textColor: DSColors.white, action: action);
}
