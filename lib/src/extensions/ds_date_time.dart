const _daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

extension DSDateTime on DateTime {
  String get formatDateToPtBr {
    final date = this;
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  bool isLeapYear(int value) =>
      value % 400 == 0 || (value % 4 == 0 && value % 100 != 0);

  int get daysInMonth {
    var result = _daysInMonth[month - 1];
    if (month == 2 && isLeapYear(year)) result++;
    return result;
  }

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool isSameDayOrGreatier(DateTime other) =>
      isSameDay(other) || isAfter(other);

  bool isSameDayOrLower(DateTime other) => isSameDay(other) || isBefore(other);

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  DateTime get startOfWeek {
    return DateTime(year, month, day - day % 7);
  }

  DateTime get endOfWeek {
    return DateTime(year, month, day - day % 7 + 6);
  }

  DateTime get startOfMonth {
    return DateTime(year, month);
  }

  DateTime get endOfMonth {
    return DateTime(year, month, daysInMonth);
  }

  DateTime get previousDay {
    if (day == 1) {
      final previousMonth = DateTime(
        year,
        month - 1,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );
      return DateTime(
        previousMonth.year,
        previousMonth.month,
        previousMonth.daysInMonth,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );
    }
    return DateTime(
      year,
      month,
      day - 1,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  DateTime get nextDay {
    if (day == daysInMonth) {
      final nextMonth = DateTime(year, month + 1);
      return DateTime(
        nextMonth.year,
        nextMonth.month,
        1,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );
    }
    return DateTime(
      year,
      month,
      day + 1,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// Adiciona dias a partir da data atual sem considerar o horário de verão
  DateTime addDays(int days) {
    // Cria um novo DateTime adicionando os dias e deixa o Dart lidar com o overflow
    final newDate = DateTime(year, month, day + days);

    // Certifica-se de que o resultado tenha um horário de 00:00:00 (meia-noite)
    return DateTime(newDate.year, newDate.month, newDate.day);
  }

  /// Remove dias da data atual sem considerar o horário de verão
  DateTime removeDays(int days) {
    // Cria um novo DateTime subtraindo os dias e deixa o Dart lidar com o underflow
    final newDate = DateTime(year, month, day - days);

    // Certifica-se de que o resultado tenha um horário de 00:00:00 (meia-noite)
    return DateTime(newDate.year, newDate.month, newDate.day);
  }

  DateTime get previousMonth {
    if (month == 1) {
      return DateTime(
        year - 1,
        12,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );
    }
    return DateTime(
      year,
      month - 1,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  DateTime get nextMonth {
    if (month == 12) {
      return DateTime(
        year + 1,
        1,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );
    }
    return DateTime(
      year,
      month + 1,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// O número da semana ISO 8601 [1..53].
  ///
  /// Algoritmo de https://en.wikipedia.org/wiki/ISO_week_date#Algorithms
  int get weekNumber {
    // Adiciona 10 ao sempre comparar com 4 de janeiro, que é sempre na semana 1
    // Adiciona 7 para indexar semanas começando com 1 em vez de 0
    final woy = (ordinalDate - weekday + 10) ~/ 7;

    // Se o número da semana for zero, significa que a data pertence ao ano anterior
    if (woy == 0) {
      // O dia 28 de dezembro é sempre na semana 53 do ano anterior
      return DateTime(year - 1, 12, 28).weekNumber;
    }

    // Se o número da semana for 53, é necessário verificar se a data não está
    // na semana 1 do ano seguinte
    if (woy == 53 &&
        DateTime(year).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  /// O dia ordinal, o número de dias desde 31 de dezembro do ano anterior.
  ///
  /// 1 de janeiro tem o dia ordinal 1
  ///
  /// 31 de dezembro tem o dia ordinal 365, ou 366 em anos bissextos
  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear(year) && month > 2 ? 1 : 0);
  }

  String getOrdinalDay() {
    if (day >= 11 && day <= 13) {
      return '$day ';
    }
    switch (day % 10) {
      case 1:
        return '$day ';
      case 2:
        return '$day ';
      case 3:
        return '$day ';
      default:
        return '$day ';
    }
  }
}
