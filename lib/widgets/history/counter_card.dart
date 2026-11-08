import 'package:flutter/material.dart';

/// Tarjeta del marcador del historial: un texto y un valor.
class CounterCard extends StatelessWidget {
  const CounterCard({
    super.key,
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
