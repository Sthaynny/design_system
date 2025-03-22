import 'package:design_system/src/widgets/grid/foundation/constants.dart';
import 'package:design_system/src/widgets/grid/layouts/ds_sliver_patterned_grid_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Um bloco de um padr o em escadas.
@immutable
class DSStairedGridTile {
  /// Um bloco de um padr o em escadas.
  /// Cria um [DSStairedGridTile].
  const DSStairedGridTile(
    this.crossAxisRatio,
    this.aspectRatio,
  )   : assert(crossAxisRatio > 0 && crossAxisRatio <= 1),
        assert(aspectRatio > 0);

  /// A quantidade de extens o que este bloco ocupa no eixo transversal, de acordo com a extens o   til dispon vel no eixo transversal.
  /// Por exemplo, se [crossAxisRatio] for 0,5, e a extens o   til dispon vel no eixo transversal for 100, ent o o bloco ter  uma extens o no eixo transversal de 50.
  ///
  /// Deve ser maior que 0 e menor ou igual a 1.
  final double crossAxisRatio;

  /// A raz o entre a extens o no eixo transversal e a extens o no eixo principal do bloco.
  ///
  /// Deve ser maior que 0.
  final double aspectRatio;

  @override
  String toString() {
    return 'DSStairedGridTile($crossAxisRatio, $aspectRatio)';
  }
}

/// Controle o layout de blocos em uma grade em escadas.
class SliverStairedGridDelegate
    extends DSSliverPatternGridDelegate<DSStairedGridTile> {
  /// Cria um [SliverStairedGridDelegate].
  const SliverStairedGridDelegate({
    required super.pattern,
    super.mainAxisSpacing,
    super.crossAxisSpacing,
    this.tileBottomSpace = 0,
    this.startCrossAxisDirectionReversed = false,
  })  : assert(tileBottomSpace >= 0),
        super.count(
          crossAxisCount: 1,
        );

  /// {@template fsgv.global.tileBottomSpace}
  /// O n mero de pixels l gicos do espa o abaixo de cada bloco.
  /// {@endtemplate}
  final double tileBottomSpace;

  /// Indica se devemos come ar a posicionar os blocos no sentido inverso do eixo transversal.
  final bool startCrossAxisDirectionReversed;

  @override
  DSSliverPatternGridGeometries getGeometries(
    SliverConstraints constraints,
    int crossAxisCount,
  ) {
    final maxCrossAxisExtent = constraints.crossAxisExtent;
    final List<SliverGridGeometry> geometries = List.filled(
      pattern.length,
      kZeroGeometry,
    );
    int i = 0;
    double mainAxisOffset = 0;
    double crossAxisOffset =
        startCrossAxisDirectionReversed ? maxCrossAxisExtent : 0;
    bool reversed = startCrossAxisDirectionReversed;
    while (i < tileCount) {
      int startIndex = i;
      double crossAxisRatioSum = 0;
      while (crossAxisRatioSum < 1 && i < tileCount) {
        crossAxisRatioSum += pattern[i].crossAxisRatio;
        i++;
      }
      if (crossAxisRatioSum > 1) {
        // A raz o final   muito alta. N o a adicionamos a esta pista.
        i--;
      }
      final tileBottomSpaceSum = tileBottomSpace * (i - startIndex);
      final isHorizontal = constraints.axis == Axis.horizontal;
      final usableCrossAxisExtent = ((startIndex == 0
                  ? maxCrossAxisExtent
                  : maxCrossAxisExtent - crossAxisSpacing) -
              (i - startIndex - 1) * crossAxisSpacing -
              (i == tileCount ? crossAxisSpacing : 0) -
              (isHorizontal ? tileBottomSpaceSum : 0))
          .clamp(0, maxCrossAxisExtent);

      double targetMainAxisOffset = 0;
      for (int j = startIndex; j < i; j++) {
        final tile = pattern[j];
        final crossAxisExtent = usableCrossAxisExtent * tile.crossAxisRatio +
            (isHorizontal ? tileBottomSpace : 0);
        final mainAxisExtent = crossAxisExtent / tile.aspectRatio +
            (isHorizontal ? 0 : tileBottomSpace);
        crossAxisOffset =
            reversed ? crossAxisOffset - crossAxisExtent : crossAxisOffset;
        final tileRect = SliverGridGeometry(
          scrollOffset: mainAxisOffset,
          crossAxisOffset: crossAxisOffset,
          mainAxisExtent: mainAxisExtent,
          crossAxisExtent: crossAxisExtent,
        );
        final endMainAxisOffset = mainAxisOffset + mainAxisExtent;

        crossAxisOffset = reversed
            ? crossAxisOffset - crossAxisSpacing
            : crossAxisOffset + crossAxisExtent + crossAxisSpacing;
        mainAxisOffset += mainAxisSpacing;
        geometries[j] = tileRect;
        if (endMainAxisOffset > targetMainAxisOffset) {
          targetMainAxisOffset = endMainAxisOffset;
        }
      }

      mainAxisOffset = targetMainAxisOffset + mainAxisSpacing;
      reversed = !reversed;
      crossAxisOffset =
          reversed ? maxCrossAxisExtent - crossAxisSpacing : crossAxisSpacing;
    }

    return DSSliverPatternGridGeometries(tiles: geometries, bounds: geometries);
  }

  @override
  bool shouldRelayout(SliverStairedGridDelegate oldDelegate) {
    return super.shouldRelayout(oldDelegate) ||
        oldDelegate.tileBottomSpace != tileBottomSpace ||
        oldDelegate.startCrossAxisDirectionReversed !=
            startCrossAxisDirectionReversed;
  }
}

