import 'package:flutter/material.dart';

abstract class DSColors {
  static Color _colorBasePrimary = const Color(0xFF1B6DDF);
  static Color _colorBaseSecundary = const Color(0xFF7D49F8);
  static MaterialColor primary = const MaterialColor(0xFF1B6DDF, {
    50: Color(0xffd9e6f9),
    100: Color(0xffb3cef4),
    200: Color(0xff8db6ef),
    300: Color(0xff679de9),
    400: Color(0xff4185e4),
    500: Color(0xff1b6ddf),
    600: Color(0xff165ab9),
    700: Color(0xff124894),
    800: Color(0xff0d366f),
    900: Color(0xff09244a),
  });
  static MaterialColor secundary = const MaterialColor(0xFF7D49F8, {
    50: Color(0xffe9e0fd),
    100: Color(0xffd3c2fc),
    200: Color(0xffbea4fb),
    300: Color(0xffa885fa),
    400: Color(0xff9267f9),
    500: Color(0xff7d49f8),
    600: Color(0xff683cce),
    700: Color(0xff5330a5),
    800: Color(0xff3e247c),
    900: Color(0xff291852),
  });
  static const Color neutralDarkCity = Color(0xFF202C44);

  static Future<void> inicialize(
      {Color? primaryColor, Color? secundaryColor}) async {
    if (primaryColor != null) {
      _colorBasePrimary = primaryColor;
    }
    if (secundaryColor != null) {
      _colorBaseSecundary = secundaryColor;
    }

    (List<Color> newShades, Color color) resultPrimary =
        _generateShades(_colorBasePrimary);

    (List<Color> newShades, Color color) resultSecundary =
        _generateShades(_colorBaseSecundary);

    primary = MaterialColor(_colorBasePrimary.toARGB32(), {
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

    secundary = MaterialColor(_colorBaseSecundary.toARGB32(), {
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
  static const gray = MaterialColor(
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
  static const Color neutralMediumWave = Color(0xFFD2DFE6);
  static const Color neutralMediumCloud = Color(0xFF8CA0B3);
}
