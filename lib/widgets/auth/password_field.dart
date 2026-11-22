import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/auth_strings.dart';

/// Campo de contraseña con un botón para mostrarla u ocultarla.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.validator,
    this.helperText,
  });

  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String? helperText;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isHidden,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        labelText: AuthStrings.passwordLabel,
        helperText: widget.helperText,
        helperMaxLines: 2,
        prefixIcon: const Icon(Icons.lock),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _isHidden = !_isHidden),
          icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
          tooltip: _isHidden ? AuthStrings.showPassword : AuthStrings.hidePassword,
        ),
      ),
      validator: widget.validator,
    );
  }
}