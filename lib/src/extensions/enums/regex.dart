enum RegExpEnum {
  caractereSeguidoPorLetraMaisculaOuNumero,
  numeroSeguidoPorLetraMaiuscula,
}

extension RegExpEnumExt on RegExpEnum {
  RegExp get exp {
    switch (this) {
      case RegExpEnum.caractereSeguidoPorLetraMaisculaOuNumero:
        return RegExp(r'(?<=[a-zA-Z])[A-Z0-9]');
      case RegExpEnum.numeroSeguidoPorLetraMaiuscula:
        return RegExp(r'(?<=[0-9])[A-Z]');
    }
  }
}
