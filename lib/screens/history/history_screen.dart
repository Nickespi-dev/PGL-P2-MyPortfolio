import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';
import 'package:my_portfolio/config/theme/app_colors.dart';
import 'package:my_portfolio/models/clock_record.dart';
import 'package:my_portfolio/models/hotel_type.dart';
import 'package:my_portfolio/utils/formatters.dart';
import 'package:my_portfolio/widgets/app_drawer.dart';
import 'package:my_portfolio/widgets/history/add_record_dialog.dart';
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

  /// Abre el modal y, si se guarda un fichaje, lo añade a la lista.
  Future<void> _addRecord() async {
    final ClockRecord? record = await showDialog<ClockRecord>(
      context: context,
      builder: (context) => const AddRecordDialog(),
    );
    // null = se pulsó Cancelar o se cerró el modal tocando fuera
    if (record == null || !mounted) return;
    setState(() => _records.add(record));
  }

  /// Muestra un modal de confirmación. Devuelve true solo si se pulsa el botón rojo.
  Future<bool> _confirm({
    required String title,
    required String message,
    required String confirmLabel,
  }) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber, color: AppColors.error),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Responde "no"
            child: const Text(AppStrings.cancelButton),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true), // Responde "sí"
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    // Cancelar devuelve false, y cerrar tocando fuera devuelve null: en los dos casos, no
    return confirmed == true;
  }

  /// Pregunta antes de borrar un fichaje y, si se confirma, lo quita de la lista.
  Future<void> _deleteRecord(int index) async {
    final ClockRecord record = _records[index];
    final bool confirmed = await _confirm(
      title: AppStrings.deleteRecordTitle,
      message: '${record.hotelName} · ${Formatters.date(record.date)}\n${record.description}',
      confirmLabel: AppStrings.deleteRecordConfirm,
    );
    if (!confirmed || !mounted) return;

    setState(() => _records.remove(record));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('${AppStrings.recordDeleted}: ${record.hotelName}')));
  }

  /// Pregunta antes de borrar todos los fichajes y, si se confirma, vacía la lista.
  Future<void> _deleteAllRecords() async {
    final bool confirmed = await _confirm(
      title: AppStrings.deleteAllTitle,
      message: AppStrings.deleteAllMessage,
      confirmLabel: AppStrings.deleteAllConfirm,
    );
    if (!confirmed || !mounted) return;

    setState(() => _records.clear());
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text(AppStrings.allRecordsDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.historyTitle),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        actions: [
          IconButton(
            // Si no hay fichajes, el botón se desactiva (gris) y no se puede pulsar
            onPressed: _records.isEmpty ? null : _deleteAllRecords,
            icon: const Icon(Icons.delete_sweep),
            tooltip: AppStrings.deleteAllTooltip,
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
              // Marcador: se actualiza solo porque se calcula a partir de la lista
              RecordCounter(count: _records.length, totalMinutes: _totalMinutes),
              Expanded(
                child: _records.isEmpty
                    ? const _EmptyHistory()
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 88), // Hueco para el botón
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
        label: const Text(AppStrings.addRecordButton),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
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
