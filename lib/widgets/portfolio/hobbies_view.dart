import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/portfolio/hobby_chip.dart';

/// Cuadrícula de hobbies. Solo construye las tarjetas que se ven en pantalla.
class HobbiesView extends StatelessWidget {
  const HobbiesView({super.key, required this.hobbies});

  final List<String> hobbies;

  static const int _columns = 2;
  static const double _chipHeight = 100;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: hobbies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _columns,
        crossAxisSpacing: 16,
        mainAxisSpacing: 10,
        mainAxisExtent: _chipHeight,
      ),
      itemBuilder: (context, index) => HobbyChip(label: hobbies[index]),
    );
  }
}
