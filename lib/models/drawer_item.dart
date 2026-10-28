import 'package:flutter/material.dart';

/// Una opción del menú lateral: icono, texto y ruta a la que lleva.
class DrawerItem {
  const DrawerItem({required this.icon, required this.title, required this.route});

  final IconData icon;
  final String title;
  final String route;
}
