import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';
import 'package:my_portfolio/config/theme/app_colors.dart';
import 'package:my_portfolio/models/clock_record.dart';
import 'package:my_portfolio/utils/formatters.dart';

/// Tarjeta de un fichaje: icono del tipo de hotel, datos y botón de borrar.
class ClockRecordTile extends StatelessWidget {
  const ClockRecordTile({super.key, required this.record, required this.onDelete});
  final ClockRecord record;
  final VoidCallback onDelete; // Lo que hace la pantalla al pulsar la papelera
  static const double _imageSize = 64;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String hours =
        '${Formatters.time(record.entry)} – ${Formatters.time(record.exit)} · '
        '${Formatters.duration(record.workedMinutes)}';
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
        child: Row(
          spacing: 12,
          children: [
            // Imagen según la categoría: el icono del tipo de hotel
            Container(
              width: _imageSize,
              height: _imageSize,
              decoration: BoxDecoration(
                color: colors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(record.hotelType.icon, size: 34, color: colors.primary),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  Text(
                    record.hotelName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    record.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                  ),
                  Text('${Formatters.date(record.date)} · $hours', style: textTheme.bodySmall),
                  Text(
                    record.hotelType.label,
                    style: textTheme.labelSmall?.copyWith(color: colors.primary),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
              color: AppColors.error,
              tooltip: AppStrings.deleteRecordTooltip,
            ),
          ],
        ),
      ),
    );
  }
}
