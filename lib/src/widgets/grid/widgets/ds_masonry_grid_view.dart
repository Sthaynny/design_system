import 'package:design_system/src/widgets/grid/rendering/ds_sliver_simple_grid_delegate.dart';
import 'package:design_system/src/widgets/grid/widgets/ds_sliver_masonry_grid.dart';
import 'package:flutter/material.dart';
/// Um array 2D rolável de widgets dispostos de acordo com o layout de alvenaria.
///
/// A direção do eixo principal de uma grade é a direção na qual ela rola (o
/// [scrollDirection]).
///
/// Os layouts de grade mais comumente usados são [DSMasonryGridView.count], que
/// cria um layout com um número fixo de blocos no eixo transversal, e
/// [DSMasonryGridView.extent], que cria um layout com blocos que têm uma
/// extensão máxima no eixo transversal. Um [SliverSimpleGridDelegate] personalizado
/// pode produzir uma disposição 2D arbitrária de filhos.
///
/// Para criar uma grade com um grande (ou infinito) número de filhos, use o
/// construtor [DSMasonryGridView.builder] com um
/// [SliverSimpleGridDelegateWithFixedCrossAxisCount] ou um
/// [DSSliverSimpleGridDelegateWithMaxCrossAxisExtent] para o [gridDelegate].
///
/// Para usar um [SliverChildDelegate] personalizado, use [DSMasonryGridView.custom].
///
/// Para criar um array linear de filhos, use um [ListView].
///
/// Para controlar o deslocamento inicial de rolagem da visualização de rolagem, forneça um
/// [controller] com sua propriedade [ScrollController.initialScrollOffset] definida.
///
/// ## Transição para [CustomScrollView]
///
/// Um [DSMasonryGridView] é basicamente um [CustomScrollView] com um único
/// [DSSliverMasonryGrid] em sua propriedade [CustomScrollView.slivers].
///
/// Se [DSMasonryGridView] não for mais suficiente, por exemplo, porque a visualização de rolagem
/// deve ter tanto uma grade quanto uma lista, ou porque a grade deve ser
/// combinada com um [SliverAppBar], etc., é direto portar o código
/// de usar [DSMasonryGridView] para usar [CustomScrollView] diretamente.
///
/// As propriedades [key], [scrollDirection], [reverse], [controller], [primary], [physics],
/// e [shrinkWrap] em [DSMasonryGridView] mapeiam diretamente para as
/// propriedades com o mesmo nome em [CustomScrollView].
///
/// A propriedade [CustomScrollView.slivers] deve ser uma lista contendo apenas um
/// [DSSliverMasonryGrid].
///
/// A propriedade [childrenDelegate] em [DSMasonryGridView] corresponde à
/// propriedade [SliverMultiBoxAdaptorWidget.delegate], e a propriedade [gridDelegate]
/// em [DSMasonryGridView] corresponde à
/// propriedade [DSSliverMasonryGrid.gridDelegate].
///
/// Os argumentos `children` dos construtores [DSMasonryGridView], [DSMasonryGridView.count] e [DSMasonryGridView.extent]
/// correspondem a [childrenDelegate]
/// sendo um [SliverChildListDelegate] com o mesmo argumento. Os
/// argumentos `itemBuilder` e `childCount` do construtor [DSMasonryGridView.builder]
/// correspondem a [childrenDelegate] sendo um
/// [SliverChildBuilderDelegate] com os argumentos correspondentes.
///
/// Os construtores [DSMasonryGridView.count] e [DSMasonryGridView.extent] criam
/// delegados de grade personalizados e têm construtores com nomes equivalentes em
/// [DSSliverMasonryGrid] para facilitar a transição: [DSSliverMasonryGrid.count] e
/// [DSSliverMasonryGrid.extent] respectivamente.
///
/// A propriedade [padding] corresponde a ter um [SliverPadding] na
/// propriedade [CustomScrollView.slivers] em vez da própria grade, e ter
/// o [SliverGrid] como um filho do [SliverPadding].
///
/// Uma vez que o código foi portado para usar [CustomScrollView], outros slivers, como
/// [SliverList] ou [SliverAppBar], podem ser colocados na lista [CustomScrollView.slivers].
///
/// Por padrão, [DSMasonryGridView] irá automaticamente adicionar preenchimento aos limites do
/// rolagem da grade para evitar obstruções parciais indicadas pelo
/// preenchimento do [MediaQuery]. Para evitar esse comportamento, substitua por uma
/// propriedade de [padding] zero.
class DSMasonryGridView extends BoxScrollView {
  /// Cria um array 2D rolável de widgets com um
  /// [SliverSimpleGridDelegate] personalizado.
  ///
  /// O argumento `addAutomaticKeepAlives` corresponde à
  /// propriedade [SliverChildListDelegate.addAutomaticKeepAlives]. O
  /// argumento `addRepaintBoundaries` corresponde à
  /// propriedade [SliverChildListDelegate.addRepaintBoundaries].
  DSMasonryGridView({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required this.gridDelegate,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    super.dragStartBehavior,
    super.clipBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
  })  : childrenDelegate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? children.length,
        );

  /// Creates a scrollable, 2D array of widgets that are created on demand and
  /// placed according to a masonry layout.
  ///
  /// This constructor is appropriate for grid views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// `itemBuilder` will be called only with indices greater than or equal to
  /// zero and less than `itemCount`.
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildBuilderDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildBuilderDelegate.addRepaintBoundaries] property. Both must not
  /// be null.
  DSMasonryGridView.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required this.gridDelegate,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  })  : childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? itemCount,
        );

  /// Creates a scrollable, 2D array of widgets with both a custom
  /// [SliverSimpleGridDelegate] and a custom [SliverChildDelegate].
  ///
  /// To use an [IndexedWidgetBuilder] callback to build children, either use
  /// a [SliverChildBuilderDelegate] or use [DSMasonryGridView.builder],
  ///  [DSMasonryGridView.count] or [DSMasonryGridView.extent] constructors.
  const DSMasonryGridView.custom({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required this.gridDelegate,
    required this.childrenDelegate,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  });

  /// Creates a scrollable, 2D array of widgets with a fixed number of tiles in
  /// the cross axis.
  ///
  /// Uses a [SliverSimpleGridDelegateWithFixedCrossAxisCount] as the
  /// [gridDelegate].
  ///
  /// The `addAutomaticKeepAlives` argument corresponds to the
  /// [SliverChildListDelegate.addAutomaticKeepAlives] property. The
  /// `addRepaintBoundaries` argument corresponds to the
  /// [SliverChildListDelegate.addRepaintBoundaries] property.
  ///
  /// See also:
  ///
  ///  * [DSSliverMasonryGrid.count], the equivalent constructor for
  ///    [DSSliverMasonryGrid].
  DSMasonryGridView.count({
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
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  })  : gridDelegate = DSSliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? itemCount,
        );

  /// Cria uma matriz 2D rolável de widgets com blocos que possuem uma
  /// extensão máxima no eixo transversal.
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
  ///  * [DSSliverMasonryGrid.extent], o construtor equivalente para
  ///    [DSSliverMasonryGrid].
  DSMasonryGridView.extent({
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
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  })  : gridDelegate = DSSliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: maxCrossAxisExtent,
        ),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
        ),
        super(
          semanticChildCount: semanticChildCount ?? itemCount,
        );

  /// Um delegate que controla o layout dos filhos dentro do
  /// [DSMasonryGridView].
  ///
  /// Os construtores [DSMasonryGridView], [DSMasonryGridView.builder] e
  /// [DSMasonryGridView.custom] permitem especificar este delegate
  /// explicitamente. Os outros construtores criam um [gridDelegate] implicitamente.
  final DSSliverSimpleGridDelegate gridDelegate;

  /// {@macro fsgv.global.mainAxisSpacing}
  final double mainAxisSpacing;

  /// {@macro fsgv.global.crossAxisSpacing}
  final double crossAxisSpacing;

  /// Um delegate que fornece os filhos para o [DSMasonryGridView].
  ///
  /// O construtor [DSMasonryGridView.custom] permite especificar este delegate
  /// explicitamente. Os outros construtores criam um [childrenDelegate] que envolve
  /// a lista de filhos fornecida.
  final SliverChildDelegate childrenDelegate;

  @override
  Widget buildChildLayout(BuildContext context) {
    return DSSliverMasonryGrid(
      delegate: childrenDelegate,
      gridDelegate: gridDelegate,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
    );
  }
}
