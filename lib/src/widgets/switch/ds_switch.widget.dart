import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.dart';
import 'ds_switch_base.widget.dart';

class DSSwitch extends DSSwitchBase {
  /// Creates a customizable switch for use alone or in conjunction with ListTile
  ///
  DSSwitch({
    super.key,
    required super.onChanged,
    required super.value,
    super.isEnabled = true,
  });

  /// Animation duration for [DSSwitch] when activate or deactivate.
  final Duration _animationDuration = const Duration(milliseconds: 400);

  /// Referring to [inactiveColor] for [isActive] false,
  final Color _inactiveColor = DSColors.grayLight.shade300;

  /// Color for background of the switch widget when [isActive] is true.
  final Color _activeColor = DSColors.grayDark.shade300;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEnabled) onChanged(!value);
      },
      child: SizedBox(
        height: 32,
        width: 56,
        child: Stack(
          children: [
            AnimatedContainer(
              curve: Curves.ease,
              duration: _animationDuration,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                color: _getSwitchColor(),
              ),
            ),
            AnimatedAlign(
              curve: Curves.ease,
              duration: _animationDuration,
              alignment: !value ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 24,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DSColors.grayLight.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSwitchColor() {
    switch (value) {
      case (true):
        return isEnabled ? _activeColor : DSColors.primary.shade300;
      case (false):
        return isEnabled ? _inactiveColor : DSColors.grayLight.shade200;
      default:
        return _activeColor;
    }
  }
}
