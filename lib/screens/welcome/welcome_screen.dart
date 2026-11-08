import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/config/constants/app_assets.dart';
import 'package:my_portfolio/config/constants/strings/welcome_strings.dart';
import 'package:my_portfolio/config/router/app_routes.dart';
import 'package:my_portfolio/widgets/welcome/welcome_top_bar.dart';

/// Pantalla de bienvenida: imagen de fondo, mensaje y botón para entrar.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const double _horizontalPadding = 28;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    // Iconos de la barra de estado en blanco, porque el fondo es oscuro.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.welcomeBackground, fit: BoxFit.cover),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(_horizontalPadding, 8, _horizontalPadding, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WelcomeTopBar(),
                    const Spacer(),
                    Text(
                      WelcomeStrings.title,
                      style: textTheme.headlineLarge?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      WelcomeStrings.message,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colors.onPrimary.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: () => context.go(AppRoutes.portfolio),
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.onPrimary,
                          foregroundColor: colors.primary,
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [Text(WelcomeStrings.enterButton), Icon(Icons.arrow_forward)],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 6,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: colors.onPrimary.withValues(alpha: 0.6),
                        ),
                        Text(
                          WelcomeStrings.location,
                          style: TextStyle(color: colors.onPrimary.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
