class DSValidators {
  /// Valida um e-mail
  String? email(String? value) {
    if (value == null || value.isEmpty) return "E-mail obrigatório";

    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(value)) return "E-mail inválido";
    return null;
  }

  /// Valida um CPF
  String? cpf(String? value, {bool validateFormat = false}) {
    if (value == null || value.isEmpty) return "CPF obrigatório";

    if (validateFormat && !cpfFormat(value)) {
      return "Formato do CPF inválido (000.000.000-00)";
    }

    if (!_validarCPF(value)) return "CPF inválido";
    return null;
  }

  /// Valida um CPF
  bool cpfFormat(String value) {
    final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
    if (!cpfRegex.hasMatch(value)) {
      return false;
    }
    return true;
  }

  /// Valida um CNPJ
  String? cnpj(String? value, {bool validateFormat = false}) {
    if (value == null || value.isEmpty) return "CNPJ obrigatório";

    if (validateFormat && !cnpjFormat(value)) {
      return "Formato do CNPJ inválido (00.000.000/0000-00)";
    }
    if (!_validarCNPJ(value)) return "CNPJ inválido";
    return null;
  }

  /// Validar formato CNPJ
  bool cnpjFormat(String value) {
    final cnpjRegex = RegExp(r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$');
    if (!cnpjRegex.hasMatch(value)) {
      return false;
    }

    return true;
  }

  /// Valida um número de telefone (aceita DDD + 8 ou 9 dígitos)
  String? telefone(String? value) {
    if (value == null || value.isEmpty) return "Telefone obrigatório";

    final telefoneRegex = RegExp(r'^\(?\d{2}\)?\s?9?\d{4}-?\d{4}$');
    if (!telefoneRegex.hasMatch(value)) return "Número de telefone inválido";

    return null;
  }

  /// Método auxiliar para validar CPF
  bool _validarCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'\D'), ''); // Remove caracteres não numéricos
    if (cpf.length != 11 || RegExp(r'(\d)\1{10}').hasMatch(cpf)) return false;

    List<int> numbers = cpf.split('').map(int.parse).toList();

    // Validação do primeiro dígito verificador
    int sum1 = 0;
    for (int i = 0; i < 9; i++) {
      sum1 += numbers[i] * (10 - i);
    }
    int check1 = (sum1 * 10) % 11 % 10;
    if (numbers[9] != check1) return false;

    // Validação do segundo dígito verificador
    int sum2 = 0;
    for (int i = 0; i < 10; i++) {
      sum2 += numbers[i] * (11 - i);
    }
    int check2 = (sum2 * 10) % 11 % 10;
    return numbers[10] == check2;
  }

  /// Método auxiliar para validar CNPJ
  bool _validarCNPJ(String cnpj) {
    cnpj =
        cnpj.replaceAll(RegExp(r'\D'), ''); // Remove caracteres não numéricos
    if (cnpj.length != 14) return false;

    List<int> numbers = cnpj.split('').map(int.parse).toList();
    List<int> weights1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> weights2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

    // Primeiro dígito verificador
    int sum1 = 0;
    for (int i = 0; i < 12; i++) {
      sum1 += numbers[i] * weights1[i];
    }
    int check1 = (sum1 % 11 < 2) ? 0 : (11 - sum1 % 11);
    if (numbers[12] != check1) return false;

    // Segundo dígito verificador
    int sum2 = 0;
    for (int i = 0; i < 13; i++) {
      sum2 += numbers[i] * weights2[i];
    }
    int check2 = (sum2 % 11 < 2) ? 0 : (11 - sum2 % 11);
    return numbers[13] == check2;
  }
}
