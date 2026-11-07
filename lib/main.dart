import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/common_strings.dart';
import 'package:my_portfolio/config/router/app_router.dart';
import 'package:my_portfolio/config/theme/app_theme.dart';

void main() {
  runApp(const EasyCheckApp());
}

/// Raíz de la app. Configura el tema y la navegación.
class EasyCheckApp extends StatelessWidget {
  const EasyCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: CommonStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
