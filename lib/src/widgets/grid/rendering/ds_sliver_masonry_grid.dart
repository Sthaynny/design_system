import 'dart:math' as math;

import 'package:design_system/src/widgets/grid/foundation/extensions.dart';
import 'package:design_system/src/widgets/grid/rendering/ds_sliver_simple_grid_delegate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// Estrutura de dados pai usada por [DSRenderSliverMasonryGrid].
class DSSliverMasonryGridParentData extends SliverMultiBoxAdaptorParentData {
  /// O índice do filho na dire o sem rolagem.
  int? crossAxisIndex;

  /// O  ltimo extent para este filho antes de ser lixo.
  /// Isso   usado para recuperar o  ltimo offset desse filho e evitar
  /// problemas de posicionamento errado.
  double? lastMainAxisExtent;

  @override
  String toString() => 'crossAxisIndex=$crossAxisIndex; ${super.toString()}';
}

/// Um sliver que coloca v  rios filhos em uma disposi o bidimensional.
///
/// [DSRenderSliverMasonryGrid] coloca cada filho o mais pr  ximo poss vel do
/// in cio da dire o principal e, em seguida, do in cio da dire o cruzada.
/// Por exemplo, em uma lista vertical, com dire o de texto da esquerda para a
/// direita, um filho ser  colocado o mais pr  ximo poss vel do topo da grade e,
/// em seguida, do lado esquerdo da grade.
///
/// O [gridDelegate] determina quantos filhos podem ser colocados na dire o
/// cruzada.
class DSRenderSliverMasonryGrid extends RenderSliverMultiBoxAdaptor {
  /// Cria um sliver que coloca seus filhos em uma disposi o de grade.
  ///
  /// Os argumentos [mainAxisSpacing] e [crossAxisSpacing] devem ser maiores que
  /// zero.
  DSRenderSliverMasonryGrid({
    required super.childManager,
    required DSSliverSimpleGridDelegate gridDelegate,
    required double mainAxisSpacing,
    required double crossAxisSpacing,
  })  : assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0),
        _gridDelegate = gridDelegate,
        _mainAxisSpacing = mainAxisSpacing,
        _crossAxisSpacing = crossAxisSpacing;

  /// {@template fsgv.global.gridDelegate}
  /// O delegado que controla o tamanho e a posi o dos filhos.
  /// {@endtemplate}
  DSSliverSimpleGridDelegate get gridDelegate => _gridDelegate;
  DSSliverSimpleGridDelegate _gridDelegate;
  set gridDelegate(DSSliverSimpleGridDelegate value) {
    if (_gridDelegate == value) {
      return;
    }

    if (value.runtimeType != _gridDelegate.runtimeType ||
        value.shouldRelayout(_gridDelegate)) {
      markNeedsLayout();
    }

    _gridDelegate = value;
  }

  /// {@template fsgv.global.mainAxisSpacing}
  /// O n mero de pixels entre cada filho na dire o principal.
  /// {@endtemplate}
  double get mainAxisSpacing => _mainAxisSpacing;
  double _mainAxisSpacing;
  set mainAxisSpacing(double value) {
    if (_mainAxisSpacing == value) {
      return;
    }
    _mainAxisSpacing = value;
    markNeedsLayout();
  }

  /// {@template fsgv.global.crossAxisSpacing}
  /// O n mero de pixels entre cada filho na dire o cruzada.
  /// {@endtemplate}
  double get crossAxisSpacing => _crossAxisSpacing;
  double _crossAxisSpacing;
  set crossAxisSpacing(double value) {
    if (_crossAxisSpacing == value) {
      return;
    }
    _crossAxisSpacing = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! DSSliverMasonryGridParentData) {
      child.parentData = DSSliverMasonryGridParentData();
    }
  }

  DSSliverMasonryGridParentData _getParentData(RenderObject child) {
    return child.parentData as DSSliverMasonryGridParentData;
  }

  double _stride = 0;
  int Function(int) _getCrossAxisIndex = (int index) => index;

  @override
  double childCrossAxisPosition(RenderBox child) {
    final crossAxisIndex = _childCrossAxisIndex(child)!;
    return _getCrossAxisIndex(crossAxisIndex) * _stride;
  }

  int? _childCrossAxisIndex(RenderBox child) {
    return _getParentData(child).crossAxisIndex;
  }

  /// Contem os ndices de eixo cruzado de todos os filhos antes do atual
  /// firstChild.
  final _previousCrossAxisIndexes = <int>[];

  /// Contem os extensos do eixo principal de todos os filhos antes do atual
  /// firstChild.
  /// N s precisamos manter isso porque o tamanho pode ter mudado desde a
  ///   ltima vez que o layout foi executado, e n s n o queremos bagun ar a
  /// disposi o.
  final _previousMainAxisExtents = <double>[];

  @override
  bool addInitialChild({int index = 0, double layoutOffset = 0.0}) {
    final hasFirstChild = super.addInitialChild(
      index: index,
      layoutOffset: layoutOffset,
    );
    if (hasFirstChild) {
      final parentData = _getParentData(firstChild!);
      parentData.applyZero();
    }
    return hasFirstChild;
  }

  @override
  void collectGarbage(int leadingGarbage, int trailingGarbage) {
    int count = leadingGarbage;
    RenderBox? child = firstChild!;
    while (count > 0 && child != null) {
      final crossAxisIndex = _childCrossAxisIndex(child);
      if (crossAxisIndex != null) {
        _previousCrossAxisIndexes.add(crossAxisIndex);
        _previousMainAxisExtents.add(paintExtentOf(child));
      }
      child = childAfter(child);
      count -= 1;
    }
    super.collectGarbage(leadingGarbage, trailingGarbage);
  }

  int _lastFirstVisibleChildIndex = 0;

  @override
  RenderBox? insertAndLayoutLeadingChild(
    BoxConstraints childConstraints, {
    bool parentUsesSize = false,
  }) {
    final child = super.insertAndLayoutLeadingChild(
      childConstraints,
      parentUsesSize: parentUsesSize,
    );
    if (child != null) {
      final parentData = _getParentData(child);
      parentData.crossAxisIndex = _previousCrossAxisIndexes.isNotEmpty
          ? _previousCrossAxisIndexes.removeLast()
          : 0;
      parentData.lastMainAxisExtent = _previousMainAxisExtents.isNotEmpty
          ? _previousMainAxisExtents.removeLast()
          : 0;
    }

    return child;
  }

  int? _lastCrossAxisCount;

  @override
  void performLayout() {
    childManager.didStartLayout();
    childManager.setDidUnderflow(false);

    final crossAxisCount = _gridDelegate.getCrossAxisCount(
      constraints,
      crossAxisSpacing,
    );

    _getCrossAxisIndex = axisDirectionIsReversed(constraints.crossAxisDirection)
        ? (int index) => crossAxisCount - index - 1
        : (int index) => index;

    // O stride   o extent do eixo cruzado de uma cela + crossAxisSpacing.
    _stride = (constraints.crossAxisExtent + crossAxisSpacing) / crossAxisCount;
    final childCrossAxisExtent = _stride - crossAxisSpacing;
    final childConstraints = constraints.asBoxConstraints(
      crossAxisExtent: childCrossAxisExtent,
    );

    final double scrollOffset =
        constraints.scrollOffset + constraints.cacheOrigin;

    assert(scrollOffset >= 0.0);
    final double remainingExtent = constraints.remainingCacheExtent;
    assert(remainingExtent >= 0.0);
    final double targetEndScrollOffset = scrollOffset + remainingExtent;
    int leadingGarbage = 0;
    int trailingGarbage = 0;
    bool reachedEnd = false;

    final scrollOffsets = List.filled(crossAxisCount, 0.0);

    double positionChild(RenderBox child) {
      // N s sempre colocamos o proximo filho na menor posi o   livre.
      final crossAxisIndex = scrollOffsets.findSmallestIndexWithMinimumValue();
      final childParentData = _getParentData(child);
      childParentData.layoutOffset = scrollOffsets[crossAxisIndex];
      childParentData.crossAxisIndex = crossAxisIndex;
      scrollOffsets[crossAxisIndex] =
          childScrollOffset(child)! + paintExtentOf(child) + mainAxisSpacing;
      return scrollOffsets[crossAxisIndex];
    }
    // Se o crossAxisCount mudou, precisamos relayoutar tudo e rolar
    // para o primeiro item visível anterior.
    if (_lastCrossAxisCount != null && _lastCrossAxisCount != crossAxisCount) {
      _previousCrossAxisIndexes.clear();
      _previousMainAxisExtents.clear();

      if (firstChild != null) {
        final firstIndex = indexOf(firstChild!);

        // Não precisamos fazer isso se o primeiro elemento já estiver visível.
        if (firstIndex != 0) {
          final lastIndex = indexOf(lastChild!);
          collectGarbage(0, lastIndex - firstIndex + 1);
          // Precisamos fazer uma correção de rolagem entre o deslocamento antigo
          // do primeiro filho e o novo.
          // Para isso, precisamos recriar todos os filhos de 0 a
          // _lastFirstVisibleChildIndex para obter o novo deslocamento do eixo principal.
          // Isso é muito caro, no entanto.
          scrollOffsets.fillRange(0, crossAxisCount, 0);
          addInitialChild();
          RenderBox? child = firstChild;
          child!.layout(childConstraints, parentUsesSize: true);
          int index = indexOf(firstChild!);
          double newPositionOfLastFirstChild = 0;

          // Isso não é realmente utilizável em depuração com muitos filhos.
          // Podemos calcular a nova posição de outra forma?

          while (child != null && index <= _lastFirstVisibleChildIndex) {
            // Sempre colocamos o próximo filho no menor índice com o valor mínimo.
            positionChild(child);
            newPositionOfLastFirstChild = childScrollOffset(child)!;
            child = insertAndLayoutChild(
              childConstraints,
              after: child,
              parentUsesSize: true,
            );
            index++;
          }

          final scrollOffsetCorrection =
              newPositionOfLastFirstChild - scrollOffset;
          if (scrollOffsetCorrection != 0) {
            geometry = SliverGeometry(
              scrollOffsetCorrection: scrollOffsetCorrection,
            );
            return;
          }
        }
      }
    }

    _lastCrossAxisCount = crossAxisCount;

    // Este algoritmo é mais genérico do que o usado pelo SliverList.

    // Certifique-se de que temos pelo menos um filho para começar.
    if (firstChild == null) {
      if (!addInitialChild()) {
        // Não há filhos.
        geometry = SliverGeometry.zero;
        childManager.didFinishLayout();
        return;
      }
    }

    // Temos pelo menos um filho.

    // Essas variáveis rastreiam o intervalo de filhos que colocamos.
    // Dentro desse intervalo, os filhos têm índices consecutivos.
    // Fora desse intervalo, é possível que um filho seja removido sem aviso.
    RenderBox? leadingChildWithLayout, trailingChildWithLayout;

    RenderBox? earliestUsefulChild = firstChild;

    // Um firstChild com deslocamento de layout nulo provavelmente é resultado
    // de reordenamento de filhos.
    //
    // Confiamos em firstChild para ter deslocamento de layout preciso.
    // No caso de deslocamento de layout nulo, temos que encontrar o primeiro filho
    // que tenha deslocamento de layout válido.
    if (childScrollOffset(firstChild!) == null) {
      int leadingChildrenWithoutLayoutOffset = 0;
      while (earliestUsefulChild != null &&
          childScrollOffset(earliestUsefulChild) == null) {
        earliestUsefulChild = childAfter(earliestUsefulChild);
        leadingChildrenWithoutLayoutOffset += 1;
      }
      // Devemos ser capazes de destruir filhos com deslocamento de layout nulo
      // com segurança, porque provavelmente estão fora do viewport
      collectGarbage(leadingChildrenWithoutLayoutOffset, 0);
      // Se não conseguir encontrar um deslocamento de layout válido, comece
      // pelo filho inicial.
      if (firstChild == null) {
        if (!addInitialChild()) {
          // Não há filhos.
          geometry = SliverGeometry.zero;
          childManager.didFinishLayout();
          return;
        }
      }
    }

    // Precisamos calcular o deslocamento de rolagem dos filhos mais antigos.
    // Cada deslocamento de rolagem deve ser menor ou igual ao scrollOffset.
    // Por enquanto, os deslocamentos de rolagem representam o deslocamento de
    // rolagem alvo do filho antes do firstChild.
    scrollOffsets.fillRange(0, crossAxisCount, double.infinity);

    // Calcula o DSSliverMasonryGridParentData para o firstChild.
    DSSliverMasonryGridParentData computeFirstChildParentData() {
      // Já colocamos este filho uma vez antes, então devemos ter retido
      // sua última extensão e crossAxisIndex.
      final firstChildParentData = _getParentData(firstChild!);
      final mainAxisExtent =
          firstChildParentData.lastMainAxisExtent! + mainAxisSpacing;
      final crossAxisIndex = firstChildParentData.crossAxisIndex!;

      double offset = scrollOffsets[crossAxisIndex] - mainAxisExtent;

      // É possível que o offset esteja muito próximo de outros offsets, mas
      // não exatamente o mesmo, devido a erros de precisão.
      // Para evitar colocação incorreta, verificamos se o offset está próximo
      // de outros offsets. Se for o caso, alteramos o offset pelo outro.
      for (int i = 0; i < crossAxisCount; i++) {
        if (i == crossAxisIndex) {
          continue;
        }
        final otherOffset = scrollOffsets[i];
        if ((offset - otherOffset).abs() < precisionErrorTolerance) {
          offset = otherOffset;
          break;
        }
      }

      return DSSliverMasonryGridParentData()
        ..layoutOffset = offset
        ..crossAxisIndex = crossAxisIndex;
    }

    RenderBox? child = firstChild;

    // Se um novo filho for inserido e não tiver um crossAxisIndex válido,
    // temos que defini-lo.
    if (child != null && indexOf(child) == 0) {
      final firstChildParentData = _getParentData(child);
      firstChildParentData.crossAxisIndex = 0;
    }

    // Populamos nossa lista earliestScrollOffsets.
    while (child != null && scrollOffsets.any((x) => x.isInfinite)) {
      final index = _childCrossAxisIndex(child);
      if (index != null) {
        final scrollOffset = childScrollOffset(child)!;
        // Só precisamos definir os deslocamentos de rolagem dos filhos mais antigos.
        if (scrollOffsets[index] == double.infinity) {
          scrollOffsets[index] = scrollOffset;
        }
      }
      child = childAfter(child);
    }

    // Encontra o primeiro filho que está visível no viewport.
    earliestUsefulChild = firstChild;
    while (scrollOffsets.any((x) => x > scrollOffset)) {
      // Temos que adicionar filhos antes do earliestUsefulChild.
      earliestUsefulChild = insertAndLayoutLeadingChild(
        childConstraints,
        parentUsesSize: true,
      );

      if (earliestUsefulChild == null) {
        // Não há mais filhos antes do firstChild atual.
        final childParentData = _getParentData(firstChild!);
        childParentData.layoutOffset = 0;

        if (scrollOffset == 0) {
          // insertAndLayoutLeadingChild só coloca os filhos antes do
          // firstChild. Neste caso, nada foi colocado. Temos que
          // colocar o firstChild manualmente.
          firstChild!.layout(childConstraints, parentUsesSize: true);
          earliestUsefulChild = firstChild;
          leadingChildWithLayout = earliestUsefulChild;
          trailingChildWithLayout ??= earliestUsefulChild;
          break;
        } else {
          // Ficamos sem filhos antes de alcançar o deslocamento de rolagem.
          // Devemos informar nosso pai que este sliver não pode cumprir
          // seu contrato e que precisamos de uma correção de deslocamento de rolagem.
          geometry = SliverGeometry(
            scrollOffsetCorrection: -scrollOffset,
          );
          return;
        }
      }

      final earliestScrollOffset = scrollOffsets.reduce(math.min);

      // firstChildScrollOffset pode conter erro de precisão dupla
      if (earliestScrollOffset < -precisionErrorTolerance) {
        // Vamos assumir que não há filho antes do primeiro filho. Vamos
        // corrigi-lo na próxima disposição, se não for.
        geometry = SliverGeometry(
          scrollOffsetCorrection: -earliestScrollOffset,
        );
        final childParentData = _getParentData(firstChild!);
        final compute = computeFirstChildParentData();
        childParentData.apply(compute);
        childParentData.layoutOffset = 0;
        return;
      }

      final firstChildParentData = computeFirstChildParentData();
      final childParentData = _getParentData(earliestUsefulChild);
      childParentData.apply(firstChildParentData);
      // Não se esqueça de atualizar os earliestScrollOffsets.
      scrollOffsets[firstChildParentData.crossAxisIndex!] =
          firstChildParentData.layoutOffset!;
      assert(earliestUsefulChild == firstChild);
      leadingChildWithLayout = earliestUsefulChild;
      trailingChildWithLayout ??= earliestUsefulChild;
    }

    assert(childScrollOffset(firstChild!)! > -precisionErrorTolerance);

    // Se o deslocamento de rolagem estiver em zero, devemos garantir que estamos
    // realmente no início da lista.
    if (scrollOffset < precisionErrorTolerance) {
      // Iteramos a partir do firstChild caso o filho líder tenha uma extensão de
      // pintura zero.
      while (indexOf(firstChild!) > 0) {
        final childParentData = _getParentData(firstChild!);
        // Corrigimos um filho por vez. Se houver mais filhos antes do
        // earliestUsefulChild, corrigiremos uma vez que o deslocamento de rolagem
        // alcance zero novamente.
        earliestUsefulChild = insertAndLayoutLeadingChild(
          childConstraints,
          parentUsesSize: true,
        );
        assert(earliestUsefulChild != null);
        final firstChildParentData = computeFirstChildParentData();
        childParentData.apply(firstChildParentData);
        final firstChildScrollOffset = firstChildParentData.layoutOffset!;
        // Só precisamos corrigir se o filho líder realmente tiver uma
        // extensão de pintura.
        if (firstChildScrollOffset < -precisionErrorTolerance) {
          geometry = SliverGeometry(
            scrollOffsetCorrection: -firstChildScrollOffset,
          );
          return;
        }
      }
    }

    // Neste ponto, earliestUsefulChild é o primeiro filho, e é um filho
    // cujo scrollOffset está em ou antes do scrollOffset, e
    // leadingChildWithLayout e trailingChildWithLayout são nulos ou
    // cobrem um intervalo de caixas de renderização que dispusemos com o
    // primeiro sendo o mesmo que earliestUsefulChild e o último sendo
    // em ou após o deslocamento de rolagem.

    assert(earliestUsefulChild == firstChild);
    assert(childScrollOffset(earliestUsefulChild!)! <= scrollOffset);

    // Certifique-se de que dispusemos pelo menos um filho.
    if (leadingChildWithLayout == null) {
      earliestUsefulChild!.layout(childConstraints, parentUsesSize: true);
      leadingChildWithLayout = earliestUsefulChild;
      trailingChildWithLayout = earliestUsefulChild;
    }

    // Aqui, earliestUsefulChild ainda é o primeiro filho, tem um
    // scrollOffset que está em ou antes do nosso scrollOffset real, e foi
    // disposto, e é de fato nosso leadingChildWithLayout. É possível
    // que alguns filhos além desse também tenham sido dispostos.
    final leadingScrollOffset = scrollOffsets.reduce(math.min);

    bool inLayoutRange = true;
    child = earliestUsefulChild;
    int index = indexOf(child!);
    // Agora, o scrollOffsets ter  os pr  ximos deslocamentos poss veis
    // para novos filhos.
    // Como earliestUsefulChild j  est  disposto, come amos atualizando os
    // deslocamentos para os pr  ximos filhos.
    scrollOffsets[_childCrossAxisIndex(child)!] =
        childScrollOffset(child)! + paintExtentOf(child) + mainAxisSpacing;

    // Tamb m  garantimos que qualquer deslocamento de rolagem infinito seja
    // ajustado para 0 agora.
    for (int i = 0; i < scrollOffsets.length; i++) {
      if (scrollOffsets[i] == double.infinity) {
        scrollOffsets[i] = 0.0;
      }
    }

    // Verifica se o scrollOffsets tem algum valor maior ou igual ao
    // scrollOffset.
    bool foundFirstVisibleChild = scrollOffsets
        .any((scrollOffset) => scrollOffset >= constraints.scrollOffset);
    _lastFirstVisibleChildIndex = indexOf(firstChild!);

    // Retorna verdadeiro se avan amos, falso se n  o temos mais filhos
    bool advance() {
      assert(child != null);
      if (child == trailingChildWithLayout) {
        inLayoutRange = false;
      }
      child = childAfter(child!);
      if (child == null) {
        inLayoutRange = false;
      }
      index += 1;
      if (!inLayoutRange) {
        if (child == null || indexOf(child!) != index) {
          // Estamos perdendo um filho. Insere-o (e disponha-o) se poss vel.
          child = insertAndLayoutChild(
            childConstraints,
            after: trailingChildWithLayout,
            parentUsesSize: true,
          );
          if (child == null) {
            // N  o temos mais filhos.
            return false;
          }
        } else {
          // Disponha o filho.
          child!.layout(childConstraints, parentUsesSize: true);
        }
        trailingChildWithLayout = child;
      }
      assert(child != null);
      positionChild(child!);
      if (!foundFirstVisibleChild &&
          scrollOffsets.any(
            (scrollOffset) => scrollOffset >= constraints.scrollOffset,
          )) {
        foundFirstVisibleChild = true;
        _lastFirstVisibleChildIndex = indexOf(child!);
      }
      assert(indexOf(child!) == index);
      return true;
    }

    // Encontre o primeiro filho que termina ap  s o scrollOffset.
    while (scrollOffsets
        .every((offset) => offset - mainAxisSpacing < scrollOffset)) {
      leadingGarbage += 1;
      if (!advance()) {
        assert(leadingGarbage == childCount);
        assert(child == null);
        // queremos garantir que mantenhamos o  ltimo filho para saber o
        // final do deslocamento de rolagem
        collectGarbage(leadingGarbage - 1, 0);
        assert(firstChild == lastChild);
        final double extent = scrollOffsets.reduce(math.max) - mainAxisSpacing;
        geometry = SliverGeometry(
          scrollExtent: extent,
          maxPaintExtent: extent,
        );
        return;
      }
    }

    // Agora, encontre o primeiro filho que termina ap  s o nosso final.
    while (scrollOffsets.any(
      (offset) => offset - mainAxisSpacing < targetEndScrollOffset,
    )) {
      if (!advance()) {
        reachedEnd = true;
        break;
      }
    }

    // Por fim, conte todos os filhos restantes e rotule-os como lixo.
    if (child != null) {
      child = childAfter(child!);
      while (child != null) {
        trailingGarbage += 1;
        child = childAfter(child!);
      }
    }

    // Agora, tudo deve estar pronto, n  o temos mais que limpar o lixo e
    // relatar a geometria.
    collectGarbage(leadingGarbage, trailingGarbage);

    assert(debugAssertChildListIsNonEmptyAndContiguous());
    final endScrollOffset = scrollOffsets.reduce(math.max) - mainAxisSpacing;
    final double estimatedMaxScrollOffset;
    if (reachedEnd) {
      estimatedMaxScrollOffset = endScrollOffset;
    } else {
      estimatedMaxScrollOffset = childManager.estimateMaxScrollOffset(
        constraints,
        firstIndex: indexOf(firstChild!),
        lastIndex: indexOf(lastChild!),
        leadingScrollOffset: leadingScrollOffset,
        trailingScrollOffset: endScrollOffset,
      );
      assert(
        estimatedMaxScrollOffset >= endScrollOffset - leadingScrollOffset,
      );
    }
    final double paintExtent = calculatePaintOffset(
      constraints,
      from: leadingScrollOffset,
      to: endScrollOffset,
    );
    final double cacheExtent = calculateCacheOffset(
      constraints,
      from: leadingScrollOffset,
      to: endScrollOffset,
    );
    final double targetEndScrollOffsetForPaint =
        constraints.scrollOffset + constraints.remainingPaintExtent;
    geometry = SliverGeometry(
      scrollExtent: estimatedMaxScrollOffset,
      paintExtent: paintExtent,
      cacheExtent: cacheExtent,
      maxPaintExtent: estimatedMaxScrollOffset,
      // Conservador para evitar que o clipe seja removido durante a rolagem.
      hasVisualOverflow: endScrollOffset > targetEndScrollOffsetForPaint ||
          constraints.scrollOffset > 0.0,
    );

    // Podemos ter iniciado o layout enquanto est vimos rolando para o final,
    // o que n  o exporia um novo filho.
    if (estimatedMaxScrollOffset == endScrollOffset) {
      childManager.setDidUnderflow(true);
    }
    childManager.didFinishLayout();
  }
}

extension on DSSliverMasonryGridParentData {
  void applyZero() {
    layoutOffset = 0.0;
    crossAxisIndex = 0;
  }

  void apply(DSSliverMasonryGridParentData parentData) {
    layoutOffset = parentData.layoutOffset;
    crossAxisIndex = parentData.crossAxisIndex;
  }
}



