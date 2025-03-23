import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Representa o modelo de dados para um m s espec fico no calend rio.
///
/// Cont m a data do m s, uma lista de datas para exibir e a primeira data
/// mostrada.
@immutable
class DSCalendarModel extends ShadCalendarModel {
  /// Cria um modelo de calend rio para um m s espec fico.
  const DSCalendarModel({
    required super.month,
    required super.dates,
    required super.firstDateShown,
  });

  @override
  int get hashCode => Object.hashAll([month, dates, firstDateShown]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DSCalendarModel &&
        other.month == month &&
        listEquals(other.dates, dates) &&
        other.firstDateShown == firstDateShown;
  }
}
/// Encapsula um in cio e fim [DateTime] que representam o intervalo de datas.
///
/// O intervalo inclui as datas de in cio e fim. As datas de in cio e fim podem
/// ser iguais para indicar um intervalo de datas de um dia. A data de in cio
/// n o deve ser ap s a data de fim.
@immutable
class DSDateTimeRange extends ShadDateTimeRange {
  /// Cria um intervalo de datas para as datas de in cio e fim especificadas.
  const DSDateTimeRange({
    /// A data de in cio do intervalo de datas.
    super.start,

    /// A data de fim do intervalo de datas.
    super.end,
  });

  /// Retorna um [Duration] do tempo entre [start] e [end].
  ///
  /// Veja [DateTime.difference] para mais detalhes.
  @override
  Duration? get duration =>
      start == null || end == null ? null : end!.difference(start!);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DateTimeRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => Object.hashAll([start, end]);

  @override
  String toString() => 'ShadDateTimeRange(start: $start, end $end)';
}

