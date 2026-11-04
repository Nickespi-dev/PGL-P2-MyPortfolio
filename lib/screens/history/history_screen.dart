import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';
import 'package:my_portfolio/models/clock_record.dart';
import 'package:my_portfolio/models/hotel_type.dart';
import 'package:my_portfolio/widgets/app_drawer.dart';
import 'package:my_portfolio/widgets/history/clock_record_tile.dart';
import 'package:my_portfolio/widgets/history/record_counter.dart';

/// Pantalla del historial de fichajes (CRUD). Guarda la lista de fichajes.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // La lista de fichajes. Empieza con dos de ejemplo.
  final List<ClockRecord> _records = [
    ClockRecord(
      hotelName: 'Hotel Atlántico',
      description: 'Turno de mañana en recepción',
      hotelType: HotelType.beach,
      date: DateTime(2026, 11, 2),
      entry: const TimeOfDay(hour: 8, minute: 0),
      exit: const TimeOfDay(hour: 16, minute: 0),
    ),
    ClockRecord(
      hotelName: 'Casa Rural El Drago',
      description: 'Turno de noche',
      hotelType: HotelType.rural,
      date: DateTime(2026, 11, 3),
      entry: const TimeOfDay(hour: 22, minute: 0),
      exit: const TimeOfDay(hour: 6, minute: 0),
    ),
  ];

  /// Suma de los minutos de todos los fichajes.
  int get _totalMinutes => _records.fold(0, (sum, record) => sum + record.workedMinutes);
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.historyTitle),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            spacing: 16,
            children: [
              // Marcador: se actualiza solo porque se calcula a partir de la lista
              RecordCounter(count: _records.length, totalMinutes: _totalMinutes),
              Expanded(
                child: _records.isEmpty
                    ? const _EmptyHistory()
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: _records.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) => ClockRecordTile(record: _records[index]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mensaje que se muestra cuando la lista está vacía.
class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Icon(Icons.history, size: 64, color: Theme.of(context).disabledColor),
          const Text(AppStrings.emptyHistory, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
