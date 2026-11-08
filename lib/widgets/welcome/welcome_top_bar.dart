import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/common_strings.dart';

/// Fila superior de la bienvenida: logo y nombre de la app.
class WelcomeTopBar extends StatelessWidget {
  const WelcomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colors.onPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.badge, color: colors.primary, size: 28),
        ),
        const SizedBox(width: 10),
        Text(
          CommonStrings.appName,
          style: TextStyle(color: colors.onPrimary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
