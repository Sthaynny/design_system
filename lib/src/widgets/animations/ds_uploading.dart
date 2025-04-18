import 'dart:async';

import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.dart';
import '../../themes/icons/ds_icons.dart';

class DSUploading extends StatefulWidget {
  final double size;
  final Color color;

  const DSUploading({
    super.key,
    this.size = 24.0,
    this.color = DSColors.white,
  });

  @override
  State<DSUploading> createState() => _DSUploadingState();
}

class _DSUploadingState extends State<DSUploading> {
  final visibleNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        visibleNotifier.value = !visibleNotifier.value;
      },
    );
  }

  @override
  void dispose() {
    visibleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: visibleNotifier,
        builder: (_, value, __) => AnimatedOpacity(
          opacity: value ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: Icon(
            DSIcons.upload_outline.data,
            color: widget.color,
            size: widget.size,
          ),
        ),
      ),
    );
  }
}
