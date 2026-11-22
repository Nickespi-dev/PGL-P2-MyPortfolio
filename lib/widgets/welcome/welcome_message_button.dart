import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/welcome_strings.dart';
import 'package:my_portfolio/models/api_response.dart';
import 'package:my_portfolio/services/auth_service.dart';
import 'package:my_portfolio/widgets/common/message_dialog.dart';

/// Botón que pide a la API el mensaje de bienvenida y lo muestra en una alerta.
class WelcomeMessageButton extends StatefulWidget {
  const WelcomeMessageButton({super.key});

  @override
  State<WelcomeMessageButton> createState() => _WelcomeMessageButtonState();
}

class _WelcomeMessageButtonState extends State<WelcomeMessageButton> {
  bool _isLoading = false;

  Future<void> _showWelcomeMessage() async {
    setState(() => _isLoading = true);
    final ApiResponse response = await AuthService.getWelcomeMessage();
    if (!mounted) return;
    setState(() => _isLoading = false);

    await MessageDialog.show(
      context,
      title: WelcomeStrings.apiMessageTitle,
      message: response.message,
      isSuccess: response.isSuccess,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: _isLoading ? null : _showWelcomeMessage,
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.onPrimary,
          side: BorderSide(color: colors.onPrimary),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        icon: _isLoading
            ? SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: colors.onPrimary),
              )
            : const Icon(Icons.waving_hand),
        label: const Text(WelcomeStrings.apiMessageButton),
      ),
    );
  }
}