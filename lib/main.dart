import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';
import 'package:my_portfolio/config/theme/app_theme.dart';
import 'package:my_portfolio/screens/portfolio/portfolio_screen.dart';

void main() {
  runApp(const EasyCheckApp());
}

/// Raíz de la app. Solo configura el tema y la pantalla inicial.
class EasyCheckApp extends StatelessWidget {
  const EasyCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const PortfolioScreen(),
    );
  }
}
