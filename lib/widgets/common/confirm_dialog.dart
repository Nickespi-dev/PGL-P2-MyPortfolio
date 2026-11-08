import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/common_strings.dart';
import 'package:my_portfolio/config/theme/app_colors.dart';

/// Modal de confirmación para acciones peligrosas, como borrar.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
  });

  final String title;
  final String message;
  final String confirmLabel;

  /// Abre el modal y devuelve true solo si se pulsa el botón de confirmar.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
  }) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) =>
          ConfirmDialog(title: title, message: message, confirmLabel: confirmLabel),
    );
    return confirmed == true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.warning_amber, color: AppColors.error),
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(CommonStrings.cancelButton),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(backgroundColor: AppColors.error),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
