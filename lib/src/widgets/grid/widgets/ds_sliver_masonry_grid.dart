import 'package:design_system/src/widgets/grid/rendering/ds_sliver_masonry_grid.dart';
import 'package:design_system/src/widgets/grid/rendering/ds_sliver_simple_grid_delegate.dart';
import 'package:flutter/material.dart';

/// Um sliver que coloca v  rios filhos em uma disposi o bidimensional.
///
/// O [DSSliverMasonryGrid] coloca cada filho o mais pr  ximo poss vel do
/// in cio do eixo principal e, em seguida, do in cio do eixo transversal.
/// Por exemplo, em uma lista vertical com dire o de texto da esquerda para
/// a direita, um filho ser  colocado o mais pr  ximo poss vel do topo da
/// grade e, em seguida, do lado esquerdo da grade.
///
/// O [gridDelegate] determina quantos filhos podem ser colocados no eixo
/// transversal.
class DSSliverMasonryGrid extends SliverMultiBoxAdaptorWidget {
  /// Cria um sliver que coloca seus filhos em uma disposi o Masonry.
  ///
  /// Os argumentos [mainAxisSpacing] e [crossAxisSpacing] devem ser maiores
  /// que zero.
  const DSSliverMasonryGrid({
    super.key,
    required super.delegate,
    required this.gridDelegate,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
  })  : assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0);

  /// Cria um sliver que coloca v  rios filhos em uma disposi o Masonry com um
  /// n mero fixo de azulejos no eixo transversal.
  ///
  /// Usa um [DSSliverSimpleGridDelegateWithFixedCrossAxisCount] como o
  /// [gridDelegate] e um [SliverChildBuilderDelegate] como o [delegate].
  ///
  /// Os argumentos [crossAxisCount], [mainAxisSpacing] e [crossAxisSpacing]
  /// devem ser maiores que zero.
  DSSliverMasonryGrid.count({
    Key? key,
    required int crossAxisCount,
    required IndexedWidgetBuilder itemBuilder,
    int? childCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
  }) : this(
          key: key,
          delegate: SliverChildBuilderDelegate(
            itemBuilder,
            childCount: childCount,
          ),
          gridDelegate: DSSliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        );

  /// Cria um sliver que coloca v  rios filhos em uma disposi o Masonry com
  /// azulejos que cada um tem um tamanho m ximo de eixo transversal.
  ///
  /// Usa um [DSSliverSimpleGridDelegateWithMaxCrossAxisExtent] como o
  /// [gridDelegate] e um [SliverChildBuilderDelegate] como o [delegate].
  ///
  /// Os argumentos [maxCrossAxisExtent], [mainAxisSpacing] e [crossAxisSpacing]
  /// devem ser maiores que zero.
  DSSliverMasonryGrid.extent({
    Key? key,
    required double maxCrossAxisExtent,
    required IndexedWidgetBuilder itemBuilder,
    int? childCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
  }) : this(
          key: key,
          delegate: SliverChildBuilderDelegate(
            itemBuilder,
            childCount: childCount,
          ),
          gridDelegate: DSSliverSimpleGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxCrossAxisExtent,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        );

  /// {@macro fsgv.global.gridDelegate}
  final DSSliverSimpleGridDelegate gridDelegate;

  /// {@macro fsgv.global.mainAxisSpacing}
  final double mainAxisSpacing;

  /// {@macro fsgv.global.crossAxisSpacing}
  final double crossAxisSpacing;

  @override
  DSRenderSliverMasonryGrid createRenderObject(BuildContext context) {
    final SliverMultiBoxAdaptorElement element =
        context as SliverMultiBoxAdaptorElement;
    return DSRenderSliverMasonryGrid(
      childManager: element,
      gridDelegate: gridDelegate,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    DSRenderSliverMasonryGrid renderObject,
  ) {
    renderObject
      ..gridDelegate = gridDelegate
      ..mainAxisSpacing = mainAxisSpacing
      ..crossAxisSpacing = crossAxisSpacing;
  }
}

