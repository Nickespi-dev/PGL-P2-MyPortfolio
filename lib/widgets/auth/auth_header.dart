import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/common_strings.dart';

/// Cabecera del login y del registro: logo, nombre de la app, título y subtítulo.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      spacing: 8,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(Icons.badge, color: colors.onPrimary, size: 36),
        ),
        Text(
          CommonStrings.appName,
          style: TextStyle(color: colors.primary, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(title, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text(subtitle, textAlign: TextAlign.center, style: textTheme.bodyMedium),
      ],
    );
  }
}