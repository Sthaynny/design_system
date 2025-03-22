import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Representa as geometrias de cada bloco de um padrão.
@immutable
class DSSliverPatternGridGeometries {
  /// Cria um [DSSliverPatternGridGeometries].
  const DSSliverPatternGridGeometries({
    required this.tiles,
    required this.bounds,
  }) : assert(tiles.length == bounds.length);

  /// As geometrias visíveis de cada bloco.
  final List<SliverGridGeometry> tiles;

  /// O espaço disponível de cada bloco.
  final List<SliverGridGeometry> bounds;
}

/// Controla o layout de uma grade que organiza um padrão repetidamente.
abstract class DSSliverPatternGridDelegate<T> extends SliverGridDelegate {
  const DSSliverPatternGridDelegate._({
    required this.pattern,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.crossAxisCount,
    this.maxCrossAxisExtent,
  })  : assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0),
        assert(crossAxisCount == null || crossAxisCount > 0),
        assert(maxCrossAxisExtent == null || maxCrossAxisExtent > 0),
        assert(crossAxisCount != null || maxCrossAxisExtent != null),
        tileCount = pattern.length;

  /// Cria um [DSSliverPatternGridDelegate] com um [crossAxisCount].
  const DSSliverPatternGridDelegate.count({
    required List<T> pattern,
    required int crossAxisCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
  }) : this._(
          pattern: pattern,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          crossAxisCount: crossAxisCount,
        );

  /// Cria um [DSSliverPatternGridDelegate] com um [maxCrossAxisExtent].
  const DSSliverPatternGridDelegate.extent({
    required List<T> pattern,
    required double maxCrossAxisExtent,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
  }) : this._(
          pattern: pattern,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          maxCrossAxisExtent: maxCrossAxisExtent,
        );

  /// {@macro fsgv.global.mainAxisSpacing}
  final double mainAxisSpacing;

  /// {@macro fsgv.global.crossAxisSpacing}
  final double crossAxisSpacing;

  /// Os blocos que representam o padrão a ser repetido.
  final List<T> pattern;

  /// O número de blocos no padrão.
  final int tileCount;

  /// {@macro fsgv.global.crossAxisCount}
  final int? crossAxisCount;

  /// {@macro fsgv.global.maxCrossAxisExtent}
  final double? maxCrossAxisExtent;

  /// Retorna as geometrias de cada bloco no padrão.
  @protected
  DSSliverPatternGridGeometries getGeometries(
    SliverConstraints constraints,
    int crossAxisCount,
  );

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final crossAxisCount = this.crossAxisCount ??
        (constraints.crossAxisExtent / (maxCrossAxisExtent! + crossAxisSpacing))
            .ceil();
    final geometries = getGeometries(constraints, crossAxisCount);
    return _SliverPatternGridLayout(
      mainAxisSpacing: mainAxisSpacing,
      crossAxisExtent: constraints.crossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
      tiles: geometries.tiles,
      bounds: geometries.bounds,
    );
  }

  @override
  bool shouldRelayout(DSSliverPatternGridDelegate oldDelegate) {
    return oldDelegate.pattern != pattern ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing;
  }
}

class _SliverPatternGridLayout extends SliverGridLayout {
  _SliverPatternGridLayout({
    required this.mainAxisSpacing,
    required this.tiles,
    required this.bounds,
    required this.crossAxisExtent,
    this.reverseCrossAxis = false,
  })  : tileCount = tiles.length,
        patternMainAxisExtent =
            bounds.last.trailingScrollOffset + mainAxisSpacing;

  final double mainAxisSpacing;
  final double crossAxisExtent;
  final bool reverseCrossAxis;
  final List<SliverGridGeometry> tiles;
  final List<SliverGridGeometry> bounds;
  final int tileCount;
  final double patternMainAxisExtent;

  @override
  double computeMaxScrollOffset(int childCount) {
    if (childCount == 0) {
      return 0;
    }

    final lastFilledPatternTrailingScrollOffset =
        (childCount ~/ tileCount) * patternMainAxisExtent;

    if (childCount % tileCount == 0) {
      return lastFilledPatternTrailingScrollOffset - mainAxisSpacing;
    }

    // Precisamos obter o deslocamento máximo de rolagem para a faixa onde o bloco com
    // índice, childCount - 1, está.
    final maxIndex = (childCount - 1) % tileCount;
    final maxRemainingScrollOffset = tiles
        .take(maxIndex + 1)
        .map((x) => x.trailingScrollOffset)
        .reduce(math.max);
    return lastFilledPatternTrailingScrollOffset + maxRemainingScrollOffset;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final startMainAxisOffset = (index ~/ tileCount) * patternMainAxisExtent;
    final rect = tileRectAt(index);
    final realRect = rect.translate(startMainAxisOffset);

    if (reverseCrossAxis) {
      return SliverGridGeometry(
        scrollOffset: realRect.scrollOffset,
        crossAxisOffset: crossAxisExtent -
            realRect.crossAxisOffset -
            realRect.crossAxisExtent,
        mainAxisExtent: realRect.mainAxisExtent,
        crossAxisExtent: realRect.crossAxisExtent,
      );
    }

    return realRect;
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    final patternCount = (scrollOffset ~/ patternMainAxisExtent);
    final mainAxisOffset = scrollOffset - patternCount * patternMainAxisExtent;
    for (int i = 0; i < tileCount; i++) {
      if (_isRectVisibleAtMainAxisOffset(bounds[i], mainAxisOffset)) {
        return i + patternCount * tileCount;
      }
    }

    return 0;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    final patternCount = (scrollOffset ~/ patternMainAxisExtent);

    final mainAxisOffset = scrollOffset - patternCount * patternMainAxisExtent;
    for (int i = tileCount - 1; i >= 0; i--) {
      if (_isRectVisibleAtMainAxisOffset(bounds[i], mainAxisOffset)) {
        return i + patternCount * tileCount;
      }
    }

    return 0;
  }

  bool _isRectVisibleAtMainAxisOffset(
    SliverGridGeometry rect,
    double mainAxisOffset,
  ) {
    return rect.scrollOffset <= mainAxisOffset &&
        rect.trailingScrollOffset >= (mainAxisOffset - mainAxisSpacing);
  }

  SliverGridGeometry tileRectAt(int index) {
    return tiles[index % tileCount];
  }
}

extension on SliverGridGeometry {
  SliverGridGeometry translate(double translation) {
    return SliverGridGeometry(
      scrollOffset: scrollOffset + translation,
      crossAxisOffset: crossAxisOffset,
      mainAxisExtent: mainAxisExtent,
      crossAxisExtent: crossAxisExtent,
    );
  }
}

