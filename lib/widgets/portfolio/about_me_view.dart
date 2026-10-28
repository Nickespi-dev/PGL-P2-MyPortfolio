import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Sección "Sobre mí": foto, presentación, QR a la tarea y botón para copiar.
class AboutMeView extends StatelessWidget {
  const AboutMeView({super.key});

  static const double _imageWidth = 180;
  static const double _qrSize = 200;
  static const double _sectionSpacing = 28;

  Future<void> _copyUrl(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: AppStrings.moodleUrl));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.linkCopied)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: _sectionSpacing, // mismo hueco entre todos los elementos
        children: [
          // Foto con las esquinas redondeadas
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(AppStrings.aboutMeImage, width: _imageWidth),
          ),

          // Tarjeta con la presentación
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.primaryContainer.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.primary.withValues(alpha: 0.5)),
            ),
            child: Text(
              AppStrings.aboutMeText,
              textAlign: TextAlign.justify,
              style: GoogleFonts.comfortaa(
                fontSize: 15,
                height: 1.5,
                color: colors.onSurface,
              ),
            ),
          ),

          // Código QR que lleva a la tarea de Moodle
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.primary, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: QrImageView(
              data: AppStrings.moodleUrl,
              size: _qrSize,
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.white,
              eyeStyle: QrEyeStyle(
                eyeShape: QrEyeShape.circle,
                color: colors.onSurface,
              ),
              dataModuleStyle: QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.circle,
                color: colors.onSurface,
              ),
            ),
          ),

          // Botón para copiar el enlace
          ElevatedButton.icon(
            onPressed: () => _copyUrl(context),
            icon: const Icon(Icons.copy),
            label: const Text(AppStrings.copyLinkButton),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.secondary,
              foregroundColor: colors.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
