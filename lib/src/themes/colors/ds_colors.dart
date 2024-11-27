import 'package:flutter/material.dart';

abstract class DSColors {
  static Color _colorBasePrimary = const Color(0xFF7D49F8);
  static Color _colorBaseSecundary = const Color(0xFF1B6DDF);
  static MaterialColor primary = const MaterialColor(0xFF7D49F8, {});
  static MaterialColor secundary = const MaterialColor(0xFF1B6DDF, {});
  static const Color neutralDarkCity = Color(0xFF202C44);

  static void inicialize({Color? primary, Color? secundary}) {
    if (primary != null) {
      _colorBasePrimary = primary;
    }
    if (secundary != null) {
      _colorBaseSecundary = secundary;
    }

    (List<Color> newShades, Color color) resultPrimary =
        _generateShades(_colorBasePrimary);

    (List<Color> newShades, Color color) resultSecundary =
        _generateShades(_colorBaseSecundary);

    primary = MaterialColor(resultPrimary.$2.value, {
      50: resultPrimary.$1[1],
      100: resultPrimary.$1[2],
      200: resultPrimary.$1[3],
      300: resultPrimary.$1[4],
      400: resultPrimary.$1[5],
      500: resultPrimary.$1[6],
      600: resultPrimary.$1[7],
      700: resultPrimary.$1[8],
      800: resultPrimary.$1[9],
      900: resultPrimary.$1[10],
    });

    secundary = MaterialColor(resultSecundary.$2.value, {
      50: resultSecundary.$1[1],
      100: resultSecundary.$1[2],
      200: resultSecundary.$1[3],
      300: resultSecundary.$1[4],
      400: resultSecundary.$1[5],
      500: resultSecundary.$1[6],
      600: resultSecundary.$1[7],
      700: resultSecundary.$1[8],
      800: resultSecundary.$1[9],
      900: resultSecundary.$1[10],
    });
  }

  // Função para gerar tons mais claros e escuros de uma cor base
  static (List<Color>, Color) _generateShades(Color color) {
    List<Color> newShades = [color];

    // Gerar 10 tons mais claros e mais escuros
    for (int i = 0; i < 6; i++) {
      // Escurecendo e clareando a cor
      double factor = (i + 1) / 6;
      newShades.insert(
          0, Color.lerp(color, Colors.white, factor)!); // Tons mais claros
      newShades
          .add(Color.lerp(color, Colors.black, factor)!); // Tons mais escuros
    }
    return (newShades, color);
  }

  /// Light gray color palette.
  static const grayLight = MaterialColor(
    0xFF667085,
    {
      50: Color(0xFFFCFCFD),
      100: Color(0xFFF9FAFB),
      150: Color(0xFFF2F4F7),
      200: Color(0xFFEAECF0),
      250: Color(0xFFD0D5DD),
      300: Color(0xFF98A2B3),
      400: Color(0xFF667085),
      500: Color(0xFF475467),
      600: Color(0xFF344054),
      700: Color(0xFF182230),
      800: Color(0xFF101828),
      900: Color(0xFF0C111D),
    },
  );

  /// Dark gray color palette.
  static const grayDark = MaterialColor(
    0xFF85888E,
    {
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F6),
      150: Color(0xFFF0F1F1),
      200: Color(0xFFECECED),
      250: Color(0xFFCECFD2),
      300: Color(0xFF94969C),
      400: Color(0xFF85888E),
      500: Color(0xFF61646C),
      600: Color(0xFF333741),
      700: Color(0xFF1F242F),
      800: Color(0xFF161B26),
      900: Color(0xFF0C111D),
    },
  );

  /// The color white
  static const white = Colors.white;

  /// The color black
  static const black = Colors.black;

  /// The color transparent
  static const transparent = Colors.transparent;

  static const Color success = Color(0xFF12825F);
  static const Color error = Color(0xFFC92929);
  static const Color warning = Color(0xFFF2AB53);
  static const Color system = Color(0xFFB2DFFD);
}
