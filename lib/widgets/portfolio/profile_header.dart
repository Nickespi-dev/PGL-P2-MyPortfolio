import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';

/// Cabecera fija con la foto de perfil y la frase de vida.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  static const double _avatarRadius = 45;
  static const double _borderWidth = 3;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: colors.secondaryContainer,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Círculo exterior de color primario = borde de la foto
          CircleAvatar(
            radius: _avatarRadius + _borderWidth,
            backgroundColor: colors.primary,
            child: const CircleAvatar(
              radius: _avatarRadius,
              backgroundImage: AssetImage(AppStrings.profileImage),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '“${AppStrings.lifeQuote}”',
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: colors.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
