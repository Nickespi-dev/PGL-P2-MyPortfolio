import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';
import 'package:my_portfolio/config/router/app_routes.dart';
import 'package:my_portfolio/models/drawer_item.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Menú lateral común a todas las pantallas.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // Opciones del menú, en el orden en que aparecen.
  static const List<DrawerItem> _items = [
    DrawerItem(icon: Icons.home, title: AppStrings.welcomeMenu, route: AppRoutes.welcome),
    DrawerItem(icon: Icons.work, title: AppStrings.portfolioMenu, route: AppRoutes.portfolio),
  ];

  void _navigateTo(BuildContext context, String route) {
    final GoRouter router = GoRouter.of(context);
    Navigator.pop(context); // Cierra el menú
    router.go(route);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String currentRoute = GoRouterState.of(context).uri.path;

    return Drawer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const _DrawerHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                for (final DrawerItem item in _items)
                  ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.title),
                    selected: item.route == currentRoute,
                    selectedColor: colors.primary,
                    selectedTileColor: colors.secondary,
                    shape: const StadiumBorder(),
                    onTap: () => _navigateTo(context, item.route),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Cabecera azul del menú con la foto, el nombre y el botón para cerrarlo.
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double topPadding = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      color: colors.primary,
      padding: EdgeInsets.fromLTRB(20, topPadding + 16, 8, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 32, backgroundImage: AssetImage(AppStrings.profileImage)),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Symbols.left_panel_close),
                color: colors.onPrimary,
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
              ),
            ],
          ),
          Text(
            AppStrings.drawerName,
            style: TextStyle(color: colors.onPrimary, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            AppStrings.drawerSubtitle,
            style: TextStyle(color: colors.onPrimary.withValues(alpha: 0.8), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
