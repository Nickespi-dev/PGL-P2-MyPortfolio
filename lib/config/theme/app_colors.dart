import 'package:flutter/material.dart';

/// Paleta de colores de Easy Check (la misma del documento de diseño).
class AppColors {
  AppColors._(); // Constructor privado: esta clase no se instancia

  // Colores de marca
  static const Color primary = Color(0xFF1E3A5F); // Azul marino
  static const Color secondary = Color(0xFFD6E2F0); // Azul claro

  // Colores de estado
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFC62828);
  static const Color warning = Color(0xFFB26A00);
  static const Color info = Color(0xFF1565C0);

  // Fondos y textos
  static const Color background = Color(0xFFF5F6F8);
  static const Color surface = Color(0xFFFFFFFF); // Tarjetas
  static const Color textPrimary = Color(0xFF1C2330);
  static const Color textSecondary = Color(0xFF5B6573);
  static const Color disabled = Color(0xFFA0A7B1);
}
