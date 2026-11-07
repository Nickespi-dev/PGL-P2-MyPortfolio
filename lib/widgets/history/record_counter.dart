import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/history_strings.dart';
import 'package:my_portfolio/config/theme/app_colors.dart';
import 'package:my_portfolio/utils/formatters.dart';

/// Marcador de arriba: número total de fichajes y horas totales.
class RecordCounter extends StatelessWidget {
  const RecordCounter({super.key, required this.count, required this.totalMinutes});

  final int count;
  final int totalMinutes;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: _CounterCard(
            label: HistoryStrings.recordsCounter,
            value: '$count',
            background: colors.primary,
            foreground: colors.onPrimary,
          ),
        ),
        Expanded(
          child: _CounterCard(
            label: HistoryStrings.hoursCounter,
            value: Formatters.duration(totalMinutes),
            background: AppColors.surface,
            foreground: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// Una de las dos tarjetas del marcador.
class _CounterCard extends StatelessWidget {
  const _CounterCard({
    required this.label,
    required this.value,
    required this.background,
    required this.foreground,
  });

  final String label;
  final String value;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          Text(label, style: TextStyle(color: foreground.withValues(alpha: 0.8), fontSize: 12)),
          Text(
            value,
            style: TextStyle(color: foreground, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
