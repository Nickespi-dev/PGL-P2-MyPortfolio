import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';
import 'package:my_portfolio/config/router/app_routes.dart';
import 'package:my_portfolio/widgets/app_drawer.dart';
import 'package:my_portfolio/widgets/portfolio/about_me_view.dart';
import 'package:my_portfolio/widgets/portfolio/hobbies_view.dart';
import 'package:my_portfolio/widgets/portfolio/portfolio_bottom_nav.dart';
import 'package:my_portfolio/widgets/portfolio/profile_header.dart';

/// Pantalla del portfolio. La pestaña que se muestra la decide la ruta.
class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key, required this.selectedIndex});

  /// Pestaña que se muestra: 0 = hobbies, 1 = sobre mí.
  final int selectedIndex;

  // Una sección por cada pestaña de la barra inferior, en el mismo orden.
  static const List<Widget> _sections = [HobbiesView(hobbies: AppStrings.hobbies), AboutMeView()];

  // La ruta de cada pestaña, en el mismo orden que las secciones.
  static const List<String> _tabRoutes = [AppRoutes.hobbies, AppRoutes.aboutMe];

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
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeader(),
            Expanded(child: _sections[selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: PortfolioBottomNav(
        currentIndex: selectedIndex,
        onTap: (index) => context.go(_tabRoutes[index]),
      ),
    );
  }
}
