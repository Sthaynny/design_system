import 'package:design_system/src/extensions/enums/regex.dart';

extension DSStringExtension on String {
  bool equals(String value) => value.compareTo(this) == 0;

  bool equalsIgnoreCase(String? value) => toLowerCase() == value?.toLowerCase();

  bool equalsTrimAndIgnoreCase(String? value) =>
      toLowerCase().trim() == value?.toLowerCase().trim();

  String get toCamelCase => toLowerCase().split(' ').map((subword) {
        if (subword.isEmpty) {
          return '';
        }
        return subword[0].toUpperCase() + subword.substring(1);
      }).join(' ');

  DateTime? get isoParaDateTime {
    if (isEmpty) {
      return null;
    }
    return DateTime.parse(this);
  }

  String get removeBreakLines => replaceAll('\n', ' ');

  String get celularSemMascaraLibPhone =>
      '+${split(' ').sublist(0).join().replaceAll(RegExp(r'\D'), '')}';

  String get celularSemMascaraLibPhoneSemPrefixoMais {
    final celular = this;
    return celular.split(' ').sublist(1).join().replaceAll(RegExp(r'\D'), '');
  }

  String get noAccents {
    final mapCaracteresBase = {
      'a': ['á', 'à', 'ã', 'â', 'ä'],
      'e': ['é', 'è', 'ê', 'ë'],
      'i': ['í', 'ì', 'î', 'ï'],
      'o': ['ó', 'ò', 'õ', 'ô', 'ö', 'ő'],
      'u': ['ú', 'ù', 'û', 'ü', 'ű'],
      'c': ['ç']
    };
    var newString = this;
    mapCaracteresBase.forEach((caractereBase, caracteresComAcento) {
      final rgxCharsComAcento = '[${caracteresComAcento.join()}]';

      newString = newString
          .replaceAll(RegExp(r'' + rgxCharsComAcento), caractereBase)
          .replaceAll(RegExp(r'' + rgxCharsComAcento.toUpperCase()),
              caractereBase.toUpperCase());
    });
    return newString;
  }

  String get toTag => noAccents
      .toLowerCase()
      .replaceAll(' ', '_')
      .replaceAll(RegExp(r'[^\w_]'), '');

  String get camelToSnakeCase => _camelDivider('_').toLowerCase();

  String get camelToKebabCase => _camelDivider('-').toLowerCase();

  String _camelDivider(String symbol) {
    var auxStr = replaceAllMapped(
      RegExpEnum.caractereSeguidoPorLetraMaisculaOuNumero.exp,
      (Match m) => '$symbol${m.group(0)}',
    );
    auxStr = auxStr.replaceAllMapped(
      RegExpEnum.numeroSeguidoPorLetraMaiuscula.exp,
      (Match m) => '$symbol${m.group(0)}',
    );
    return auxStr;
  }

  String get comPontoFinal => '$this.';

  bool contemTrecho(String trecho) =>
      toLowerCase().contains(trecho.toLowerCase());
}
