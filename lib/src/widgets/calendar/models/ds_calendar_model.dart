import 'package:flutter/foundation.dart';
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
}
