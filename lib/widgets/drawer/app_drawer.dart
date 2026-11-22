import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/config/constants/strings/drawer_strings.dart';
import 'package:my_portfolio/config/router/app_routes.dart';
import 'package:my_portfolio/config/theme/app_colors.dart';
import 'package:my_portfolio/models/drawer_item.dart';
import 'package:my_portfolio/services/auth_service.dart';
import 'package:my_portfolio/widgets/common/confirm_dialog.dart';
import 'package:my_portfolio/widgets/drawer/app_drawer_header.dart';

/// Menú lateral común a todas las pantallas.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // Opciones del menú, en el orden en que aparecen.
  static const List<DrawerItem> _items = [
    DrawerItem(icon: Icons.home, title: DrawerStrings.welcome, route: AppRoutes.welcome),
    DrawerItem(icon: Icons.work, title: DrawerStrings.portfolio, route: AppRoutes.portfolio),
    DrawerItem(icon: Icons.history, title: DrawerStrings.history, route: AppRoutes.history),
  ];

  void _navigateTo(BuildContext context, String route) {
    final GoRouter router = GoRouter.of(context);
    Navigator.pop(context); // Cierra el menú
    router.go(route);
  }

  // Cerrar sesión: borra el token y vuelve al login.
  Future<void> _logout(BuildContext context) async {
    final GoRouter router = GoRouter.of(context);
    final bool confirmed = await ConfirmDialog.show(
      context,
      title: DrawerStrings.logoutTitle,
      message: DrawerStrings.logoutMessage,
      confirmLabel: DrawerStrings.logoutConfirm,
    );
    if (!confirmed) return;

    await AuthService.logout();
    router.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String currentRoute = GoRouterState.of(context).uri.path;

    return Drawer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const AppDrawerHeader(),
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

          // Cerrar sesión
          const Divider(height: 1),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(DrawerStrings.logout),
                iconColor: AppColors.error,
                textColor: AppColors.error,
                shape: const StadiumBorder(),
                onTap: () => _logout(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}