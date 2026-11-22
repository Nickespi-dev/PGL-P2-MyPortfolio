import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/common_strings.dart';
import 'package:my_portfolio/config/theme/app_colors.dart';

/// Alerta con la respuesta de la API: icono verde si ha ido bien y rojo si ha fallado.
class MessageDialog extends StatelessWidget {
  const MessageDialog({super.key, required this.message, required this.isSuccess, this.title});

  final String message;
  final bool isSuccess;
  final String? title;

  /// Muestra la alerta y espera a que el usuario pulse Aceptar.
  static Future<void> show(
    BuildContext context, {
    required String message,
    required bool isSuccess,
    String? title,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => MessageDialog(message: message, isSuccess: isSuccess, title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        isSuccess ? Icons.check_circle : Icons.error,
        color: isSuccess ? AppColors.success : AppColors.error,
      ),
      title: Text(title ?? (isSuccess ? CommonStrings.successTitle : CommonStrings.errorTitle)),
      content: Text(message, textAlign: TextAlign.center),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(CommonStrings.acceptButton),
        ),
      ],
    );
  }
}