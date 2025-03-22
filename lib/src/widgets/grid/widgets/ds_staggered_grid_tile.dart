import 'package:design_system/src/widgets/grid/rendering/ds_staggered_grid.dart';
import 'package:design_system/src/widgets/grid/widgets/ds_staggered_grid.dart';
import 'package:flutter/material.dart';

/// Representa o tamanho de um tile de uma [StaggeredGrid].
class DSStaggeredGridTile extends ParentDataWidget<DSStaggeredGridParentData> {
  const DSStaggeredGridTile._({
    super.key,
    required this.crossAxisCellCount,
    required this.mainAxisCellCount,
    required this.mainAxisExtent,
    required super.child,
  })  : assert(crossAxisCellCount > 0),
        assert(mainAxisCellCount == null || mainAxisCellCount > 0),
        assert(mainAxisExtent == null || mainAxisExtent > 0);

  /// Cria um tile de uma [StaggeredGrid] que ocupa um número fixo de células
  /// ao longo do eixo principal.
  const DSStaggeredGridTile.count({
    Key? key,
    required int crossAxisCellCount,
    required num mainAxisCellCount,
    required Widget child,
  }) : this._(
          key: key,
          crossAxisCellCount: crossAxisCellCount,
          mainAxisCellCount: mainAxisCellCount,
          mainAxisExtent: null,
          child: child,
        );

  /// Cria um tile de uma [StaggeredGrid] que ocupa um espaço específico ao
  /// longo do eixo principal.
  const DSStaggeredGridTile.extent({
    Key? key,
    required int crossAxisCellCount,
    required double mainAxisExtent,
    required Widget child,
  }) : this._(
          key: key,
          crossAxisCellCount: crossAxisCellCount,
          mainAxisCellCount: null,
          mainAxisExtent: mainAxisExtent,
          child: child,
        );

  /// Cria um tile de uma [StaggeredGrid] que ajusta o seu tamanho ao longo do
  /// eixo principal para se adequar ao conteúdo do seu [child].
  const DSStaggeredGridTile.fit({
    Key? key,
    required int crossAxisCellCount,
    required Widget child,
  }) : this._(
          key: key,
          crossAxisCellCount: crossAxisCellCount,
          mainAxisCellCount: null,
          mainAxisExtent: null,
          child: child,
        );

  /// O número de células que este tile ocupa ao longo do eixo transversal.
  final int crossAxisCellCount;

  /// O número de células que este tile ocupa ao longo do eixo principal.
  final num? mainAxisCellCount;

  /// O espaço que este tile ocupa ao longo do eixo principal.
  final double? mainAxisExtent;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData;
    if (parentData is DSStaggeredGridParentData) {
      bool needsLayout = false;

      if (parentData.crossAxisCellCount != crossAxisCellCount) {
        parentData.crossAxisCellCount = crossAxisCellCount;
        needsLayout = true;
      }

      if (parentData.mainAxisCellCount != mainAxisCellCount) {
        parentData.mainAxisCellCount = mainAxisCellCount;
        needsLayout = true;
      }

      if (parentData.mainAxisExtent != mainAxisExtent) {
        parentData.mainAxisExtent = mainAxisExtent;
        needsLayout = true;
      }

      if (needsLayout) {
        final targetParent = renderObject.parent;
        if (targetParent is DSRenderStaggeredGrid) {
          targetParent.markNeedsLayout();
        }
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => DSStaggeredGrid;
}

