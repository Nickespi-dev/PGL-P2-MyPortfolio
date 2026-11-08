import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/history_strings.dart';
import 'package:my_portfolio/config/theme/app_colors.dart';
import 'package:my_portfolio/utils/formatters.dart';
import 'package:my_portfolio/widgets/history/counter_card.dart';

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
          child: CounterCard(
            label: HistoryStrings.recordsCounter,
            value: '$count',
            background: colors.primary,
            foreground: colors.onPrimary,
          ),
        ),
        Expanded(
          child: CounterCard(
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
