import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/history_strings.dart';
import 'package:my_portfolio/models/clock_record.dart';
import 'package:my_portfolio/models/hotel_type.dart';
import 'package:my_portfolio/utils/formatters.dart';
import 'package:my_portfolio/widgets/common/confirm_dialog.dart';
import 'package:my_portfolio/widgets/drawer/app_drawer.dart';
import 'package:my_portfolio/widgets/history/add_record_dialog.dart';
import 'package:my_portfolio/widgets/history/clock_record_tile.dart';
import 'package:my_portfolio/widgets/history/empty_history.dart';
import 'package:my_portfolio/widgets/history/record_counter.dart';

/// Pantalla del historial de fichajes (CRUD). Guarda la lista de fichajes.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Fichajes de ejemplo
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

  int get _totalMinutes => _records.fold(0, (sum, record) => sum + record.workedMinutes);

  // Añadir
  Future<void> _addRecord() async {
    final ClockRecord? record = await showDialog<ClockRecord>(
      context: context,
      builder: (context) => const AddRecordDialog(),
    );
    if (record == null || !mounted) return;
    setState(() => _records.add(record));
  }

  // Borrar un fichaje
  Future<void> _deleteRecord(int index) async {
    final ClockRecord record = _records[index];
    final bool confirmed = await ConfirmDialog.show(
      context,
      title: HistoryStrings.deleteRecordTitle,
      message: '${record.hotelName} · ${Formatters.date(record.date)}\n${record.description}',
      confirmLabel: HistoryStrings.deleteRecordConfirm,
    );
    if (!confirmed || !mounted) return;

    setState(() => _records.remove(record));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('${HistoryStrings.recordDeleted}: ${record.hotelName}')),
      );
  }

  // Borrar todos los fichajes
  Future<void> _deleteAllRecords() async {
    final bool confirmed = await ConfirmDialog.show(
      context,
      title: HistoryStrings.deleteAllTitle,
      message: HistoryStrings.deleteAllMessage,
      confirmLabel: HistoryStrings.deleteAllConfirm,
    );
    if (!confirmed || !mounted) return;

    setState(() => _records.clear());
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text(HistoryStrings.allRecordsDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(HistoryStrings.title),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        actions: [
          IconButton(
            onPressed: _records.isEmpty ? null : _deleteAllRecords,
            icon: const Icon(Icons.delete_sweep),
            tooltip: HistoryStrings.deleteAllTooltip,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            spacing: 16,
            children: [
              RecordCounter(count: _records.length, totalMinutes: _totalMinutes),
              Expanded(
                child: _records.isEmpty
                    ? const EmptyHistory()
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 88),
                        itemCount: _records.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) => ClockRecordTile(
                          record: _records[index],
                          onDelete: () => _deleteRecord(index),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addRecord,
        icon: const Icon(Icons.add),
        label: const Text(HistoryStrings.addRecordButton),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
    );
  }
}
