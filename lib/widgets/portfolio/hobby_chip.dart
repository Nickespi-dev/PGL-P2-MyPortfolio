import 'package:flutter/material.dart';

/// Tarjeta de un hobby. Su tamaño lo decide la cuadrícula que la contiene.
class HobbyChip extends StatelessWidget {
  const HobbyChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        border: Border.all(color: colors.primary, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, color: colors.onPrimaryContainer),
          ),
        ),
      ),
    );
  }
}
