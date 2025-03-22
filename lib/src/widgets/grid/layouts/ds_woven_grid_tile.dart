import 'dart:math' as math;

import 'package:design_system/src/widgets/grid/foundation/constants.dart';
import 'package:design_system/src/widgets/grid/layouts/ds_sliver_patterned_grid_delegate.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Um bloco de um padr o em uma grade de tecelagem.
@immutable
class DSWovenGridTile {
  /// Cria um [DSWovenGridTile].
  const DSWovenGridTile(
    this.aspectRatio, {
    this.crossAxisRatio = 1,
    this.alignment = AlignmentDirectional.center,
  })  : assert(aspectRatio > 0),
        assert(crossAxisRatio > 0 && crossAxisRatio <= 1);

  /// A raz o entre o eixo transversal e o eixo principal do bloco.
  ///
  /// Deve ser maior que 0.
  final double aspectRatio;

  /// A raz o entre o tamanho do bloco no eixo transversal e o tamanho do eixo
  /// transversal.
  ///
  /// Deve estar entre 0 (exclusivo) e 1 (inclusivo).
  final double crossAxisRatio;

  /// A alinhacao do bloco dentro do espaco disponivel.
  final AlignmentDirectional alignment;

  @override
  String toString() {
    return 'DSWovenGridTile($aspectRatio${crossAxisRatio > 1 ? ', $crossAxisRatio' : ''}${alignment != AlignmentDirectional.center ? ', $alignment' : ''})';
  }
}

/// Controla o layout de blocos em uma grade de tecelagem.
class DSSliverWovenGridDelegate extends DSSliverPatternGridDelegate<DSWovenGridTile> {
  /// Cria um [DSSliverWovenGridDelegate].
  const DSSliverWovenGridDelegate.count({
    required super.pattern,
    required super.crossAxisCount,
    super.mainAxisSpacing,
    super.crossAxisSpacing,
    this.tileBottomSpace = 0,
  })  : assert(pattern.length <= crossAxisCount),
        super.count();

  /// Cria um [DSSliverWovenGridDelegate].
  const DSSliverWovenGridDelegate.extent({
    required super.pattern,
    required super.maxCrossAxisExtent,
    super.mainAxisSpacing,
    super.crossAxisSpacing,
    this.tileBottomSpace = 0,
  }) : super.extent();

  /// O espaco entre os blocos na direcao do eixo principal.
  final double tileBottomSpace;

  @override
  DSSliverPatternGridGeometries getGeometries(
    SliverConstraints constraints,
    int crossAxisCount,
  ) {
    final isHorizontal = constraints.axis == Axis.horizontal;
    final usableCrossAxisExtent = isHorizontal
        ? constraints.crossAxisExtent - crossAxisCount * tileBottomSpace
        : constraints.crossAxisExtent;
    final crossAxisExtent =
        (usableCrossAxisExtent + crossAxisSpacing) / crossAxisCount -
            crossAxisSpacing;
    final crossAxisStride = crossAxisExtent + crossAxisSpacing;
    final patternCount = pattern.length;
    // A raz o de aspecto m nima   a altura de uma faixa.
    final maxMainAxisExtentRatio =
        pattern.map((t) => t.crossAxisRatio / t.aspectRatio).reduce(math.max);
    final mainAxisExtent = crossAxisExtent * maxMainAxisExtentRatio +
        (isHorizontal ? 0 : tileBottomSpace);

    // N s sempre fornecemos 2 faixas onde o layout segue este padr o:
    // A B A || A B A B || A B C || A B C A
    // B A B || B A B A || C B A || B A C B

    final count = crossAxisCount * 2;
    final tiles = List.filled(count, kZeroGeometry);
    final bounds = List.filled(count, kZeroGeometry);
    for (int i = 0; i < count; i++) {
      final startScrollOffset =
          i < crossAxisCount ? 0.0 : mainAxisExtent + mainAxisSpacing;
      final tilePatternIndex = i < crossAxisCount
          ? i % patternCount
          : (count - 1 - (i % crossAxisCount)) % patternCount;
      final tilePattern = pattern[tilePatternIndex];
      final tileCrossAxisExtent = crossAxisExtent * tilePattern.crossAxisRatio +
          (isHorizontal ? tileBottomSpace : 0);
      final tileMainAxisExtent = tileCrossAxisExtent / tilePattern.aspectRatio +
          (isHorizontal ? 0 : tileBottomSpace);
      final effectiveTextDirection =
          i < crossAxisCount ? TextDirection.ltr : TextDirection.rtl;
      final effectiveAlignment =
          tilePattern.alignment.resolve(effectiveTextDirection);
      final rect = effectiveAlignment.inscribe(
        Size(tileCrossAxisExtent, tileMainAxisExtent),
        Rect.fromLTWH(0, 0, crossAxisExtent, mainAxisExtent),
      );
      final startCrossAxisOffset = (i % crossAxisCount) * crossAxisStride;
      tiles[i] = SliverGridGeometry(
        scrollOffset: startScrollOffset + rect.top,
        crossAxisOffset: startCrossAxisOffset + rect.left,
        mainAxisExtent: tileMainAxisExtent,
        crossAxisExtent: tileCrossAxisExtent,
      );
      bounds[i] = SliverGridGeometry(
        scrollOffset: startScrollOffset,
        crossAxisOffset: startCrossAxisOffset,
        mainAxisExtent: mainAxisExtent,
        crossAxisExtent: crossAxisExtent,
      );
    }

    return DSSliverPatternGridGeometries(tiles: tiles, bounds: bounds);
  }

  @override
  bool shouldRelayout(DSSliverWovenGridDelegate oldDelegate) {
    return super.shouldRelayout(oldDelegate) ||
        oldDelegate.tileBottomSpace != tileBottomSpace ||
        oldDelegate.crossAxisCount != crossAxisCount;
  }
}

