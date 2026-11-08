import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:my_portfolio/config/constants/app_assets.dart';
import 'package:my_portfolio/config/constants/strings/drawer_strings.dart';

/// Cabecera azul del menú con la foto, el nombre y el botón para cerrarlo.
class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

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
              const CircleAvatar(radius: 32, backgroundImage: AssetImage(AppAssets.profileImage)),
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
            DrawerStrings.name,
            style: TextStyle(color: colors.onPrimary, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            DrawerStrings.subtitle,
            style: TextStyle(color: colors.onPrimary.withValues(alpha: 0.8), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
