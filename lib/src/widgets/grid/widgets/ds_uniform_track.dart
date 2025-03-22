import 'package:design_system/src/widgets/grid/rendering/ds_uniform_track.dart';
import 'package:flutter/material.dart';

class DSUniformTrack extends MultiChildRenderObjectWidget {
  const DSUniformTrack({
    super.key,
    required this.division,
    this.spacing = 0,
    required this.direction,
    required super.children,
  })  : assert(spacing >= 0),
        assert(division > 0),
        assert(children.length <= division);

  final double spacing;
  final int division;
  final AxisDirection direction;

  @override
  DSRenderUniformTrack createRenderObject(BuildContext context) {
    return DSRenderUniformTrack(
      direction: direction,
      division: division,
      spacing: spacing,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant DSRenderUniformTrack renderObject,
  ) {
    renderObject
      ..direction = direction
      ..division = division
      ..spacing = spacing;
  }
}
