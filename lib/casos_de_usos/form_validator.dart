class FormValidator {
  static String? validateEmpty(String? value, int maxlength) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório.';
    } else if (value.length > maxlength) {
      return 'Esse campo deve conter no maximo $maxlength caracteres ';
    }
    return null;
  }
}
