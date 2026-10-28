import 'package:flutter/material.dart';
import 'package:my_portfolio/config/theme/app_colors.dart';

/// Tema de la app. Todos los widgets leen sus colores de aquí.
class AppTheme {
  AppTheme._(); // Constructor privado: esta clase no se instancia

  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.secondary,
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.primary,
      secondaryContainer: AppColors.secondary,
      onSecondaryContainer: AppColors.primary,
      error: AppColors.error,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.background,
    disabledColor: AppColors.disabled,
  );
}