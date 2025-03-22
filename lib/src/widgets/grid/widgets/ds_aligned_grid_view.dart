import 'package:design_system/src/widgets/grid/rendering/ds_sliver_simple_grid_delegate.dart';
import 'package:design_system/src/widgets/grid/widgets/ds_sliver_aligned_grid.dart';
import 'package:flutter/material.dart';

/// Uma matriz 2D rolável de widgets colocados de acordo com o layout alinhado.
///
/// A direção do eixo principal de uma grade é a direção na qual ela rola (o
/// [scrollDirection]).
///
/// Os layouts de grade mais comumente usados são [DSAlignedGridView.count], que
/// cria um layout com um número fixo de ladrilhos no eixo cruzado, e
/// [DSAlignedGridView.extent], que cria um layout com ladrilhos que têm uma
/// extensão máxima no eixo cruzado. Um [DSSliverSimpleGridDelegate] personalizado pode produzir
/// um arranjo 2D arbitrário de filhos.
///
/// Para criar um array linear de filhos, use um [ListView].
///
/// Para controlar o deslocamento inicial de rolagem da visualização de rolagem, forneça um
/// [controller] com sua propriedade [ScrollController.initialScrollOffset] definida.
///
/// ## Transição para [CustomScrollView]
///
/// Um [DSAlignedGridView] é basicamente um [CustomScrollView] com um único
/// [SliverAlignedGrid] em sua propriedade [CustomScrollView.slivers].
///
/// Se [DSAlignedGridView] não for mais suficiente, por exemplo porque a visualização de rolagem
/// deve ter uma grade e uma lista, ou porque a grade deve ser
/// combinada com um [SliverAppBar], etc, é simples portar o código
/// de usar [DSAlignedGridView] para usar [CustomScrollView] diretamente.
///
/// As propriedades [key], [scrollDirection], [reverse], [controller], [primary], [physics],
/// e [shrinkWrap] em [DSAlignedGridView] mapeiam diretamente para as
/// propriedades com o mesmo nome em [CustomScrollView].
///
/// A propriedade [CustomScrollView.slivers] deve ser uma lista contendo apenas um
/// [SliverAlignedGrid].
///
/// Os construtores [DSAlignedGridView.count] e [DSAlignedGridView.extent] criam
/// delegados de grade personalizados e têm construtores com nomes equivalentes em
/// [SliverAlignedGrid] para facilitar a transição: [SliverAlignedGrid.count] e
/// [SliverAlignedGrid.extent] respectivamente.
///
/// A propriedade [padding] corresponde a ter um [SliverPadding] na
/// propriedade [CustomScrollView.slivers] em vez da própria grade, e ter
/// o [SliverGrid] em vez disso como um filho do [SliverPadding].
///
/// Uma vez que o código tenha sido portado para usar [CustomScrollView], outros slivers, como
/// [SliverList] ou [SliverAppBar], podem ser colocados na lista [CustomScrollView.slivers].
///
/// Por padrão, [DSAlignedGridView] irá automaticamente acolchoar os limites da
/// área rolável da grade para evitar obstruções parciais indicadas pelo
/// acolchoamento do [MediaQuery]. Para evitar esse comportamento, substitua com um
/// valor zero na propriedade [padding].
class DSAlignedGridView extends BoxScrollView {
  /// Cria uma matriz 2D rolável de widgets com um
  /// [DSSliverSimpleGridDelegate] personalizado.
  const DSAlignedGridView.custom({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required this.gridDelegate,
    required this.itemBuilder,
    this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  });

  /// Cria uma matriz 2D rolável de widgets com um número fixo de ladrilhos no
  /// eixo cruzado.
  ///
  /// Usa um [DSSliverSimpleGridDelegateWithFixedCrossAxisCount] como o
  /// [gridDelegate].
  ///
  /// O argumento `addAutomaticKeepAlives` corresponde à propriedade
  /// [SliverChildListDelegate.addAutomaticKeepAlives]. O argumento
  /// `addRepaintBoundaries` corresponde à propriedade
  /// [SliverChildListDelegate.addRepaintBoundaries].
  ///
  /// Veja também:
  ///
  ///  * [SliverAlignedGrid.count], o construtor equivalente para
  ///    [SliverAlignedGrid].
  DSAlignedGridView.count({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required int crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    required this.itemBuilder,
    this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  })  : gridDelegate = DSSliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        super(
          semanticChildCount: semanticChildCount ?? itemCount,
        );

  /// Cria uma matriz 2D rolável de widgets com ladrilhos que têm cada um uma
  /// extensão máxima no eixo cruzado.
  ///
  /// Usa um [DSSliverSimpleGridDelegateWithMaxCrossAxisExtent] como o
  /// [gridDelegate].
  ///
  /// O argumento `addAutomaticKeepAlives` corresponde à propriedade
  /// [SliverChildListDelegate.addAutomaticKeepAlives]. O argumento
  /// `addRepaintBoundaries` corresponde à propriedade
  /// [SliverChildListDelegate.addRepaintBoundaries].
  ///
  /// Veja também:
  ///
  ///  * [SliverAlignedGrid.extent], o construtor equivalente para
  ///    [SliverAlignedGrid].
  DSAlignedGridView.extent({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required double maxCrossAxisExtent,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    required this.itemBuilder,
    this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  })  : gridDelegate = DSSliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
        ),
        super(
          semanticChildCount: semanticChildCount ?? itemCount,
        );

  /// Um delegate que controla o layout dos filhos dentro do
  /// [DSAlignedGridView].
  ///
  /// O construtor [DSAlignedGridView.custom] permite especificar este delegate
  /// explicitamente. Os outros construtores criam um [gridDelegate] implicitamente.
  final DSSliverSimpleGridDelegate gridDelegate;

  /// Espaçamento principal entre eixos.
  final double mainAxisSpacing;

  /// Espaçamento transversal entre eixos.
  final double crossAxisSpacing;

  /// Chamado para construir os filhos para o sliver.
  ///
  /// Será chamado apenas para índices maiores ou iguais a zero e menores
  /// que [itemCount] (se [itemCount] não for nulo).
  ///
  /// Deve retornar nulo se solicitado a construir um widget com um índice maior
  /// do que existe.
  ///
  /// O delegate envolve os filhos retornados por este construtor em
  /// widgets [RepaintBoundary].
  final NullableIndexedWidgetBuilder itemBuilder;

  /// O número total de filhos que este delegate pode fornecer.
  ///
  /// Se nulo, o número de filhos é determinado pelo menor índice para o qual
  /// [itemBuilder] retorna nulo.
  final int? itemCount;

  /// Se deve envolver cada filho em um [AutomaticKeepAlive].
  ///
  /// Tipicamente, os filhos em uma lista preguiçosa são envolvidos em widgets
  /// [AutomaticKeepAlive] para que possam usar [KeepAliveNotification]s para
  /// preservar seu estado quando de outra forma seriam coletados como lixo fora da tela.
  ///
  /// Este recurso (e [addRepaintBoundaries]) deve ser desativado se os filhos
  /// forem manter manualmente seu estado [KeepAlive]. Também pode ser mais
  /// eficiente desativar este recurso se for sabido de antemão que nenhum dos
  /// filhos tentará se manter vivo.
  ///
  /// O padrão é verdadeiro.
  final bool addAutomaticKeepAlives;

  /// Se deve envolver cada filho em um [RepaintBoundary].
  ///
  /// Tipicamente, os filhos em um contêiner de rolagem são envolvidos em
  /// limites de repintura para que não precisem ser repintados enquanto a lista
  /// rola. Se os filhos forem fáceis de repintar (por exemplo, blocos de cor
  /// sólida ou um trecho curto de texto), pode ser mais eficiente não adicionar
  /// um limite de repintura e simplesmente repintar os filhos durante a rolagem.
  ///
  /// O padrão é verdadeiro.
  final bool addRepaintBoundaries;

  @override
  Widget buildChildLayout(BuildContext context) {
    return DSSliverAlignedGrid(
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      gridDelegate: gridDelegate,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
    );
  }
}
