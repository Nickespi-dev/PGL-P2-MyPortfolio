import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';
import 'package:my_portfolio/widgets/portfolio/about_me_view.dart';
import 'package:my_portfolio/widgets/portfolio/hobbies_view.dart';
import 'package:my_portfolio/widgets/portfolio/portfolio_bottom_nav.dart';
import 'package:my_portfolio/widgets/portfolio/profile_header.dart';

/// Pantalla del portfolio. Guarda qué pestaña está seleccionada.
class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  // Una sección por cada pestaña de la barra inferior, en el mismo orden.
  static const List<Widget> _sections = [
    HobbiesView(hobbies: AppStrings.hobbies),
    AboutMeView(),
  ];

  // El estado de la app: qué pestaña está seleccionada.
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeader(),
            Expanded(child: _sections[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: PortfolioBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
