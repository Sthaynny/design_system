import 'package:design_system/src/widgets/grid/rendering/ds_staggered_grid.dart';
import 'package:flutter/material.dart';

/// Um grid que organiza os filhos em uma disposição irregular.
/// Cada filho pode ter um tamanho diferente.
/// Envie seus filhos com um [StaggeredGridTile] para especificar seu tamanho se
/// ele for diferente de um tile de 1x1.
class DSStaggeredGrid extends MultiChildRenderObjectWidget {
  /// Cria um [DSStaggeredGrid] com um delegado personalizado.
  const DSStaggeredGrid.custom({
    super.key,
    required this.delegate,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.axisDirection,
    super.children,
  })  : assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0);

  /// Cria um [DSStaggeredGrid] usando um delegado personalizado
  /// [DSStaggeredGridDelegateWithFixedCrossAxisCount] como [delegate].
  ///
  /// O grid ter  um n mero fixo de tiles no eixo transversal.
  DSStaggeredGrid.count({
    Key? key,
    required int crossAxisCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    AxisDirection? axisDirection,
    List<Widget> children = const <Widget>[],
  }) : this.custom(
          key: key,
          delegate: DSStaggeredGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          axisDirection: axisDirection,
          children: children,
        );

  /// Cria um [DSStaggeredGrid] usando um delegado personalizado
  /// [DSStaggeredGridDelegateWithMaxCrossAxisExtent] como [delegate].
  ///
  /// O grid ter  tiles que cada um tem um tamanho m ximo no eixo transversal.
  DSStaggeredGrid.extent({
    Key? key,
    required double maxCrossAxisExtent,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    AxisDirection? axisDirection,
    List<Widget> children = const <Widget>[],
  }) : this.custom(
          key: key,
          delegate: DSStaggeredGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxCrossAxisExtent,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          axisDirection: axisDirection,
          children: children,
        );

  /// O delegado que controla a disposi o dos filhos.
  final DSStaggeredGridDelegate delegate;

  /// Espa o entre os filhos no eixo principal.
  final double mainAxisSpacing;

  /// Espa o entre os filhos no eixo transversal.
  final double crossAxisSpacing;

  /// A dire o do eixo principal do grid.
  final AxisDirection? axisDirection;

  @override
  DSRenderStaggeredGrid createRenderObject(BuildContext context) {
    return DSRenderStaggeredGrid(
      delegate: delegate,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      axisDirection: axisDirection ??
          Scrollable.maybeOf(context)?.axisDirection ??
          AxisDirection.down,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    DSRenderStaggeredGrid renderObject,
  ) {
    renderObject
      ..delegate = delegate
      ..mainAxisSpacing = mainAxisSpacing
      ..crossAxisSpacing = crossAxisSpacing
      ..axisDirection = axisDirection ??
          Scrollable.maybeOf(context)?.axisDirection ??
          AxisDirection.down
      ..textDirection = Directionality.of(context);
  }
}
