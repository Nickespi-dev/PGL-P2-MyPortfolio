import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';

/// Barra de navegación inferior. No guarda estado: recibe la pestaña activa
/// y avisa al padre con [onTap] cuando se pulsa otra.
class PortfolioBottomNav extends StatelessWidget {
  const PortfolioBottomNav({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap; // Función que recibe el índice pulsado

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: colors.primary,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: AppStrings.hobbiesTab),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: AppStrings.aboutMeTab),
      ],
    );
  }
}
