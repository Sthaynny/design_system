import 'dart:math' as math;

import 'package:design_system/src/widgets/grid/foundation/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Um bloco para [DSSliverQuiltedGridDelegate].
@immutable
class DSQuiltedGridTile {
  /// Cria um [DSQuiltedGridTile].
  const DSQuiltedGridTile(
    this.mainAxisCount,
    this.crossAxisCount,
  )   : assert(mainAxisCount > 0),
        assert(crossAxisCount > 0);

  /// O número de células que o bloco ocupa no eixo principal.
  final int mainAxisCount;

  /// O número de células que o bloco ocupa no eixo cruzado.
  final int crossAxisCount;

  @override
  String toString() {
    return 'DSQuiltedGridTile($mainAxisCount, $crossAxisCount)';
  }
}

/// Controla o layout de uma grade acolchoada.
class DSSliverQuiltedGridDelegate extends SliverGridDelegate {
  /// Cria um [DSSliverQuiltedGridDelegate].
  DSSliverQuiltedGridDelegate({
    required this.crossAxisCount,
    required List<DSQuiltedGridTile> pattern,
    this.repeatPattern = QuiltedGridRepeatPattern.same,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
  })  : assert(crossAxisCount > 0),
        assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0),
        assert(pattern.isNotEmpty),
        _pattern = pattern.toPattern(crossAxisCount, repeatPattern);

  /// {@macro fsgv.global.crossAxisCount}
  final int crossAxisCount;

  /// Descreve como o padrão está se repetindo.
  ///
  /// O valor padrão é [QuiltedGridRepeatPattern.same].
  final QuiltedGridRepeatPattern repeatPattern;

  /// {@macro fsgv.global.mainAxisSpacing}
  final double mainAxisSpacing;

  /// {@macro fsgv.global.crossAxisSpacing}
  final double crossAxisSpacing;

  final _QuiltedTilePattern _pattern;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final crossAxisExtent = constraints.crossAxisExtent;
    final cellExtent = (crossAxisExtent + crossAxisSpacing) / crossAxisCount -
        crossAxisSpacing;
    return _SliverQuiltedGridLayout(
      cellExtent: cellExtent,
      crossAxisExtent: crossAxisExtent,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      pattern: _pattern,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(DSSliverQuiltedGridDelegate oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing;
  }
}

class _QuiltedTilePattern {
  const _QuiltedTilePattern({
    required this.tiles,
    required this.crossAxisIndexes,
    required this.mainAxisIndexes,
    required this.maxMainAxisCellCounts,
    required this.minTileIndexes,
    required this.maxTileIndexes,
    required this.mainAxisCellCount,
  }) : tileCount = tiles.length;

  final List<DSQuiltedGridTile> tiles;
  final int tileCount;
  final List<int> crossAxisIndexes;
  final List<int> mainAxisIndexes;
  final List<int> maxMainAxisCellCounts;
  final List<int> minTileIndexes;
  final List<int> maxTileIndexes;
  final int mainAxisCellCount;

  /// Obtém o índice do eixo cruzado do bloco no [index] fornecido.
  int crossAxisIndexOf(int index) {
    return crossAxisIndexes[index % tileCount];
  }

  /// Obtém o índice do eixo principal do bloco no [index] fornecido.
  int mainAxisIndexOf(int index) {
    return mainAxisIndexes[index % tileCount];
  }

  /// Obtém o número de células no eixo principal para exibir totalmente todos os blocos
  /// deste padrão se quisermos exibir [count] blocos.
  int maxMainAxisCellCountOf(int count) {
    return maxMainAxisCellCounts[count % tileCount];
  }

  int getMinTileIndexForMainAxisIndex(int mainAxisIndex) {
    return minTileIndexes[mainAxisIndex % mainAxisCellCount];
  }

  int getMaxTileIndexForMainAxisIndex(int mainAxisIndex) {
    return maxTileIndexes[mainAxisIndex % mainAxisCellCount];
  }

  DSQuiltedGridTile tileOf(int index) {
    return tiles[index % tileCount];
  }
}

/// Layout que se parece com a lista de imagens acolchoadas em
/// https://material.io/components/image-lists.
class _SliverQuiltedGridLayout extends SliverGridLayout {
  const _SliverQuiltedGridLayout({
    required double cellExtent,
    required this.crossAxisExtent,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.pattern,
    required this.reverseCrossAxis,
  })  : assert(cellExtent > 0),
        assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0),
        mainAxisStride = cellExtent + mainAxisSpacing,
        crossAxisStride = cellExtent + crossAxisSpacing;

  final double crossAxisExtent;

  /// {@macro fsgv.global.mainAxisSpacing}
  final double mainAxisSpacing;

  /// {@macro fsgv.global.crossAxisSpacing}
  final double crossAxisSpacing;

  final double mainAxisStride;

  final double crossAxisStride;

  final _QuiltedTilePattern pattern;

  /// Se as crianças devem ser colocadas na ordem inversa de coordenadas
  /// crescentes no eixo cruzado.
  ///
  /// Por exemplo, se o eixo cruzado for horizontal, as crianças são colocadas da
  /// esquerda para a direita quando [reverseCrossAxis] é falso e da direita para a esquerda quando
  /// [reverseCrossAxis] é verdadeiro.
  ///
  /// Tipicamente definido para o valor de retorno de [axisDirectionIsReversed] aplicado ao
  /// [SliverConstraints.crossAxisDirection].
  final bool reverseCrossAxis;

  @override
  double computeMaxScrollOffset(int childCount) {
    // Primeiro, calculamos o número de células ocupadas no eixo principal pelos padrões preenchidos.

    if (childCount == 0) {
      return 0;
    }

    final mainAxisCellCountBeforeLastPattern =
        (childCount ~/ pattern.tileCount) * pattern.mainAxisCellCount;

    final remainingChildCount = childCount % pattern.tileCount;

    // Em seguida, obtemos o número de células do eixo principal no último padrão.
    final remainingMainAxisCellCount = remainingChildCount == 0
        ? 0
        : pattern.maxMainAxisCellCountOf(remainingChildCount - 1);

    // Calculamos o número total de células no eixo principal.
    final nbCellsInMainAxis =
        mainAxisCellCountBeforeLastPattern + remainingMainAxisCellCount;

    return nbCellsInMainAxis * mainAxisStride - mainAxisSpacing;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    // Primeiro, calculamos o número de células ocupadas no eixo principal pelos padrões preenchidos.
    final mainAxisCellCountBeforeLastPattern =
        (index ~/ pattern.tileCount) * pattern.mainAxisCellCount;
    final mainAxisIndex =
        mainAxisCellCountBeforeLastPattern + pattern.mainAxisIndexOf(index);
    final crossAxisIndex = pattern.crossAxisIndexOf(index);
    final tile = pattern.tileOf(index);

    final crossAxisExtent =
        tile.crossAxisCount * crossAxisStride - crossAxisSpacing;

    return SliverGridGeometry(
      scrollOffset: mainAxisIndex * mainAxisStride,
      crossAxisOffset: _getOffsetFromStartInCrossAxis(
        crossAxisIndex * crossAxisStride,
        crossAxisExtent,
      ),
      mainAxisExtent: tile.mainAxisCount * mainAxisStride - mainAxisSpacing,
      crossAxisExtent: crossAxisExtent,
    );
  }

  double _getOffsetFromStartInCrossAxis(
    double crossAxisStart,
    double childCrossAxisExtent,
  ) {
    if (reverseCrossAxis) {
      return crossAxisExtent - crossAxisStart - childCrossAxisExtent;
    }
    return crossAxisStart;
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    final mainAxisIndex = (scrollOffset ~/ mainAxisStride);
    final a = (mainAxisIndex ~/ pattern.mainAxisCellCount) * pattern.tileCount;
    final result = a + pattern.getMinTileIndexForMainAxisIndex(mainAxisIndex);
    return result;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    final mainAxisIndex = (scrollOffset ~/ mainAxisStride);
    final a = (mainAxisIndex ~/ pattern.mainAxisCellCount) * pattern.tileCount;
    final result = a + pattern.getMaxTileIndexForMainAxisIndex(mainAxisIndex);
    return result;
  }
}

/// Define como um padrão está se repetindo.
abstract class QuiltedGridRepeatPattern {
  /// Construtor abstrato const. Este construtor permite que subclasses forneçam
  /// construtores const para que possam ser usados em expressões const.
  const QuiltedGridRepeatPattern();

  /// O mesmo padrão está se repetindo repetidamente.
  static const QuiltedGridRepeatPattern same = _QuiltedGridRepeatSamePattern();

  /// A cada dois blocos, o padrão é invertido (por inversão central).
  ///
  /// Por exemplo, o seguinte padrão:
  ///
  /// A A C D
  /// A A E E
  ///
  /// Será invertido para:
  ///
  /// E E A A
  /// D C A A
  static const QuiltedGridRepeatPattern inverted =
      _QuiltedGridRepeatInvertedPattern();

  /// A cada dois blocos, o padrão é espelhado (por simetria axial).
  ///
  /// Por exemplo, o seguinte padrão:
  ///
  /// A A C D
  /// A A E E
  ///
  /// Será espelhado para:
  ///
  /// A A E E
  /// A A C D
  static const QuiltedGridRepeatPattern mirrored =
      _QuiltedGridRepeatMirroredPattern();

  /// Retorna os índices na ordem do padrão repetido.
  List<int> repeatedIndexes(List<int> indexes, int crossAxisCount);

  /// Retorna o número de blocos no padrão repetido.
  int repeatedTileCount(int tileCount);
}

class _QuiltedGridRepeatSamePattern extends QuiltedGridRepeatPattern {
  const _QuiltedGridRepeatSamePattern();

  @override
  List<int> repeatedIndexes(List<int> indexes, int crossAxisCount) {
    return [];
  }

  @override
  int repeatedTileCount(int tileCount) => 0;
}

class _QuiltedGridRepeatInvertedPattern extends QuiltedGridRepeatPattern {
  const _QuiltedGridRepeatInvertedPattern();

  @override
  List<int> repeatedIndexes(List<int> indexes, int crossAxisCount) {
    // Iteramos pelos índices em ordem inversa para obter o índice dos blocos em ordem inversa.
    final result = <int>[];
    final added = <int>{};
    for (int i = indexes.length - 1; i >= 0; i--) {
      final index = indexes[i];
      if (index != -1 && !added.contains(index)) {
        result.add(index);
        added.add(index);
      }
    }

    return result;
  }

  @override
  int repeatedTileCount(int tileCount) => tileCount;
}

class _QuiltedGridRepeatMirroredPattern extends QuiltedGridRepeatPattern {
  const _QuiltedGridRepeatMirroredPattern();

  @override
  List<int> repeatedIndexes(List<int> indexes, int crossAxisCount) {
    // Iteramos pelos índices em ordem inversa para obter o índice dos blocos em ordem inversa.
    final result = <int>[];
    final added = <int>{};

    final mainAxisCount = indexes.length ~/ crossAxisCount;

    for (int i = mainAxisCount - 1; i >= 0; i--) {
      for (int j = 0; j < crossAxisCount; j++) {
        final index = indexes[i * crossAxisCount + j];
        if (index != -1 && !added.contains(index)) {
          result.add(index);
          added.add(index);
        }
      }
    }

    return result;
  }

  @override
  int repeatedTileCount(int tileCount) => tileCount;
}

extension on List<DSQuiltedGridTile> {
  _QuiltedTilePattern toPattern(
    int crossAxisCount,
    QuiltedGridRepeatPattern repeatPattern,
  ) {
    final tileCount = length + repeatPattern.repeatedTileCount(length);
    final minTileIndexes = <int>[];
    final maxTileIndexes = <int>[];
    final maxMainAxisCellCounts = List<int>.filled(tileCount, 0);
    final mainAxisIndexes = List<int>.filled(tileCount, 0);
    final crossAxisIndexes = List<int>.filled(tileCount, 0);
    // O índice do bloco ocupado por cada célula.
    final indexes = <int, int>{};

    final offsets = List<int>.generate(crossAxisCount, (index) => 0);
    void position(
      List<DSQuiltedGridTile> tiles,
      Map<int, int>? indexes,
      int start,
    ) {
      for (int i = 0; i < tiles.length; i++) {
        final tile = tiles[i];
        final fullIndex = start + i;
        final crossAxisIndex = offsets.findSmallestIndexWithMinimumValue();
        final mainAxisIndex = offsets[crossAxisIndex];
        mainAxisIndexes[fullIndex] = mainAxisIndex;
        crossAxisIndexes[fullIndex] = crossAxisIndex;

        // Atualizamos os deslocamentos.
        final tileCrossAxisCount = tile.crossAxisCount;
        final tileMainAxisCount = tile.mainAxisCount;
        for (int j = 0; j < tileCrossAxisCount; j++) {
          offsets[crossAxisIndex + j] += tileMainAxisCount;

          if (indexes != null) {
            for (int k = 0; k < tileMainAxisCount; k++) {
              final cellIndex =
                  (crossAxisIndex + j) + (mainAxisIndex + k) * crossAxisCount;
              indexes[cellIndex] = i;
            }
          }
        }

        // Atualizamos os índices mínimo e máximo do bloco.
        for (int j = 0; j < tileMainAxisCount; j++) {
          final index = mainAxisIndex + j;
          if (minTileIndexes.length == index) {
            minTileIndexes.add(fullIndex);
          } else {
            minTileIndexes[index] = math.min(minTileIndexes[index], fullIndex);
          }
          if (maxTileIndexes.length == index) {
            maxTileIndexes.add(fullIndex);
          } else {
            maxTileIndexes[index] = math.max(maxTileIndexes[index], fullIndex);
          }
        }

        maxMainAxisCellCounts[fullIndex] = offsets.reduce(math.max);
      }
    }

    position(this, indexes, 0);
    final indexList = List<int>.filled(indexes.length, -1);
    for (final index in indexes.keys) {
      indexList[index] = indexes[index]!;
    }
    final repeatedIndexes = repeatPattern.repeatedIndexes(
      indexList,
      crossAxisCount,
    );
    final tiles = toList();
    if (repeatedIndexes.isNotEmpty) {
      final repeatedTiles =
          repeatedIndexes.map((index) => this[index]).toList();
      position(repeatedTiles, null, length);
      tiles.addAll(repeatedTiles);
    }

    return _QuiltedTilePattern(
      tiles: tiles,
      mainAxisIndexes: mainAxisIndexes,
      crossAxisIndexes: crossAxisIndexes,
      maxMainAxisCellCounts: maxMainAxisCellCounts,
      minTileIndexes: minTileIndexes,
      maxTileIndexes: maxTileIndexes,
      mainAxisCellCount: offsets.reduce(math.max),
    );
  }
}

