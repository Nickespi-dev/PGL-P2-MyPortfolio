import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/auth_strings.dart';
import 'package:my_portfolio/utils/validators.dart';

/// Campo del correo electrónico con teclado de email y su validación.
class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: AuthStrings.emailLabel,
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
      validator: Validators.email,
    );
  }
}