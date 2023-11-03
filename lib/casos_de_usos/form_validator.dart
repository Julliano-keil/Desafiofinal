///validates the field and size according to what the user enters
class FormValidator {
  ///method to validate
  static String? validateEmpty(String? value, int maxlength) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório.';
    } else if (value.length > maxlength) {
      return 'Esse campo deve conter  $maxlength caracteres ';
    }
    return null;
  }
}
