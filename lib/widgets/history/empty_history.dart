import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/history_strings.dart';

/// Mensaje del historial cuando la lista está vacía.
class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Icon(Icons.history, size: 64, color: Theme.of(context).disabledColor),
          const Text(HistoryStrings.emptyHistory, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
