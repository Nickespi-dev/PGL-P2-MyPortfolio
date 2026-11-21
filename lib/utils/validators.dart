import 'package:my_portfolio/config/constants/strings/auth_strings.dart';
import 'package:my_portfolio/config/constants/strings/common_strings.dart';

/// Validaciones de los formularios de registro e inicio de sesión.
class Validators {
  Validators._();

  static final RegExp _emailRegExp = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)*\.[a-zA-Z]{2,}$');

  static String? fullName(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return CommonStrings.requiredField;
    if (text.split(RegExp(r'\s+')).length < 2) return AuthStrings.fullNameError;
    return null;
  }

  static String? email(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return CommonStrings.requiredField;
    if (!_emailRegExp.hasMatch(text)) return AuthStrings.emailError;
    return null;
  }

  // En el login solo se comprueba que no esté vacía.
  static String? requiredPassword(String? value) =>
      (value == null || value.isEmpty) ? CommonStrings.requiredField : null;

  // En el registro se exige una contraseña segura.
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) return CommonStrings.requiredField;
    if (value.length < 8) return AuthStrings.passwordLengthError;
    if (!value.contains(RegExp(r'[A-Z]'))) return AuthStrings.passwordUppercaseError;
    if (!value.contains(RegExp(r'[a-z]'))) return AuthStrings.passwordLowercaseError;
    if (!value.contains(RegExp(r'[0-9]'))) return AuthStrings.passwordNumberError;
    if (!value.contains(RegExp(r'[^A-Za-z0-9]'))) return AuthStrings.passwordSymbolError;
    return null;
  }
}