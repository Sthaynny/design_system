import 'package:design_system/src/widgets/grid/rendering/ds_sliver_simple_grid_delegate.dart';
import 'package:design_system/src/widgets/grid/widgets/ds_uniform_track.dart';
import 'package:flutter/widgets.dart';

/// Um sliver que coloca v  rios filhos em uma disposi o bidimensional.
///
/// [DSSliverAlignedGrid] coloca seus filhos em uma grade onde cada faixa tem a
/// largura do eixo principal do filho mais largo. Cada filho   esticado para
/// corresponder   largura da faixa do eixo principal.
class DSSliverAlignedGrid extends StatelessWidget {
  /// Cria um [DSSliverAlignedGrid] personalizado.
  const DSSliverAlignedGrid({
    super.key,
    required this.itemBuilder,
    this.itemCount,
    required this.gridDelegate,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
  });

  /// Cria um sliver que coloca v  rios filhos em uma disposi o bidimensional com
  /// um n mero fixo de faixas no eixo transversal.
  ///
  /// Os argumentos [crossAxisCount], [mainAxisSpacing] e [crossAxisSpacing]
  /// devem ser maiores que zero.
  DSSliverAlignedGrid.count({
    Key? key,
    required NullableIndexedWidgetBuilder itemBuilder,
    int? itemCount,
    required int crossAxisCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
  }) : this(
          key: key,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          gridDelegate: DSSliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        );

  /// Cria um sliver que coloca v  rios filhos em uma disposi o bidimensional com
  /// faixas que cada uma tem uma largura m xima do eixo transversal.
  ///
  /// Os argumentos [maxCrossAxisExtent], [mainAxisSpacing] e [crossAxisSpacing]
  /// devem ser maiores que zero.
  DSSliverAlignedGrid.extent({
    Key? key,
    required NullableIndexedWidgetBuilder itemBuilder,
    int? itemCount,
    required double maxCrossAxisExtent,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
  }) : this(
          key: key,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          gridDelegate: DSSliverSimpleGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxCrossAxisExtent,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        );

  /// {@macro fsgv.global.mainAxisSpacing}
  final double mainAxisSpacing;

  /// {@macro fsgv.global.crossAxisSpacing}
  final double crossAxisSpacing;

  /// {@macro fsgv.global.gridDelegate}
  final DSSliverSimpleGridDelegate gridDelegate;

  /// Chamado para construir filhos para o sliver.
  ///
  /// Ser   chamado apenas para ndices maiores ou iguais a zero e menores que
  /// [itemCount] (se [itemCount] n o for nulo).
  ///
  /// Deve retornar nulo se for solicitado para construir um widget com um ndice
  /// maior do que existe.
  ///
  /// O delegate envolve os filhos retornados por este construtor em
  /// [RepaintBoundary] widgets.
  final NullableIndexedWidgetBuilder itemBuilder;

  /// O n mero total de filhos que este delegate pode fornecer.
  ///
  /// Se nulo, o n mero de filhos   determinado pelo ndice menor para o qual
  /// [itemBuilder] retorna nulo.
  final int? itemCount;

  /// Se deve ou n o envolver cada filho em um [AutomaticKeepAlive].
  ///
  /// Normalmente, os filhos em listas pregui os s o envolvidos em [AutomaticKeepAlive]
  /// widgets para que os filhos possam usar [KeepAliveNotification]s para preservar
  /// seu estado quando eles seriam, de outra forma, coletados como lixo fora da tela.
  ///
  /// Este recurso (e [addRepaintBoundaries]) deve ser desativado se os filhos
  /// estiverem manualmente mantendo seu estado [KeepAlive]. Al m disso, pode ser
  /// mais eficiente desativar este recurso se for sabido   frente que n n os filhos
  /// tentar o manter seu estado.
  ///
  /// Padr o   verdadeiro.
  final bool addAutomaticKeepAlives;

  /// Se deve ou n o envolver cada filho em um [RepaintBoundary].
  ///
  /// Normalmente, os filhos em um cont iner de rolagem s o envolvidos em
  /// [RepaintBoundary] para que eles n o precisam ser redesenhados   medida que
  /// a lista rola. Se os filhos forem f ceis de redesenhar (por exemplo, blocos de
  /// cor s lida ou um trecho curto de texto), pode ser mais eficiente n o adicionar
  /// um [RepaintBoundary] e simplesmente redesenhar os filhos durante a rolagem.
  ///
  /// Padr o   verdadeiro.
  final bool addRepaintBoundaries;

  @override
  Widget build(BuildContext context) {
    final localItemCount = itemCount;
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = gridDelegate.getCrossAxisCount(
          constraints,
          crossAxisSpacing,
        );
        final listItemCount = localItemCount == null
            ? null
            : ((localItemCount + crossAxisCount - 1) ~/ crossAxisCount) * 2 - 1;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index.isOdd) {
                return _Gap(mainAxisExtent: mainAxisSpacing);
              }

              final startIndex = (index ~/ 2) * crossAxisCount;
              final children = [
                for (int i = 0; i < crossAxisCount; i++)
                  _buildItem(context, startIndex + i, itemCount),
              ].whereType<Widget>();

              if (children.isEmpty) {
                return null;
              }

              return DSUniformTrack(
                direction: constraints.crossAxisDirection,
                division: crossAxisCount,
                spacing: crossAxisSpacing,
                children: [...children],
              );
            },
            childCount: listItemCount,
          ),
        );
      },
    );
  }

  Widget? _buildItem(BuildContext context, int index, int? childCount) {
    if (index < 0 || (childCount != null && index >= childCount)) {
      return null;
    }

    return itemBuilder(context, index);
  }
}

class _Gap extends StatelessWidget {
  const _Gap({
    required this.mainAxisExtent,
  });

  final double mainAxisExtent;

  @override
  Widget build(BuildContext context) {
    final axis = axisDirectionToAxis(Scrollable.of(context).axisDirection);
    return axis == Axis.vertical
        ? SizedBox(height: mainAxisExtent)
        : SizedBox(width: mainAxisExtent);
  }
}
