import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/app_strings.dart';
import 'package:my_portfolio/models/clock_record.dart';
import 'package:my_portfolio/models/hotel_type.dart';
import 'package:my_portfolio/utils/formatters.dart';

/// Modal con el formulario para añadir un fichaje.
/// Al guardar, se cierra y devuelve el fichaje nuevo con Navigator.pop.
class AddRecordDialog extends StatefulWidget {
  const AddRecordDialog({super.key});
  @override
  State<AddRecordDialog> createState() => _AddRecordDialogState();
}

class _AddRecordDialogState extends State<AddRecordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hotelController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  // Valores del formulario que no son texto
  HotelType? _hotelType; // null hasta que se elige uno
  DateTime _date = DateTime.now();
  TimeOfDay _entry = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _exit = const TimeOfDay(hour: 16, minute: 0);

  @override
  void dispose() {
    // Los controladores se liberan al cerrar el modal
    _hotelController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime({required bool isEntry}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isEntry ? _entry : _exit,
    );
    if (picked == null) return;
    setState(() {
      if (isEntry) {
        _entry = picked;
      } else {
        _exit = picked;
      }
    });
  }

  /// Validador de los campos de texto: no pueden quedar vacíos.
  String? _requiredText(String? value) =>
      (value == null || value.trim().isEmpty) ? AppStrings.requiredField : null;
  void _save() {
    // validate() ejecuta todos los validator y devuelve false si alguno falla
    if (!_formKey.currentState!.validate()) return;

    final ClockRecord record = ClockRecord(
      hotelName: _hotelController.text.trim(),
      description: _descriptionController.text.trim(),
      hotelType: _hotelType!, // No es null: el validador lo ha comprobado
      date: _date,
      entry: _entry,
      exit: _exit,
    );
    Navigator.pop(context, record); // Cierra el modal y devuelve el fichaje
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 14,
            children: [
              Text(AppStrings.addRecordTitle, style: Theme.of(context).textTheme.titleLarge),
              // Nombre
              TextFormField(
                controller: _hotelController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: AppStrings.hotelNameLabel,
                  prefixIcon: Icon(Icons.hotel),
                  border: OutlineInputBorder(),
                ),
                validator: _requiredText,
              ),
              // Descripción breve (máximo 60 caracteres)
              TextFormField(
                controller: _descriptionController,
                maxLength: 60,
                decoration: const InputDecoration(
                  labelText: AppStrings.descriptionLabel,
                  prefixIcon: Icon(Icons.notes),
                  border: OutlineInputBorder(),
                ),
                validator: _requiredText,
              ),
              // Selector de categoría: un elemento por cada tipo de hotel
              DropdownButtonFormField<HotelType>(
                initialValue: _hotelType,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: AppStrings.hotelTypeLabel,
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final HotelType type in HotelType.values)
                    DropdownMenuItem(
                      value: type,
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(type.icon, color: colors.primary),
                          Text(type.label),
                        ],
                      ),
                    ),
                ],
                onChanged: (type) => setState(() => _hotelType = type),
                validator: (type) => type == null ? AppStrings.chooseHotelType : null,
              ),
              // Fecha y horas
              _PickerField(
                label: AppStrings.dateLabel,
                value: Formatters.date(_date),
                icon: Icons.calendar_today,
                onTap: _pickDate,
              ),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: _PickerField(
                      label: AppStrings.entryLabel,
                      value: Formatters.time(_entry),
                      icon: Icons.login,
                      onTap: () => _pickTime(isEntry: true),
                    ),
                  ),
                  Expanded(
                    child: _PickerField(
                      label: AppStrings.exitLabel,
                      value: Formatters.time(_exit),
                      icon: Icons.logout,
                      onTap: () => _pickTime(isEntry: false),
                    ),
                  ),
                ],
              ),
              // Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), // Cierra sin devolver nada
                    child: const Text(AppStrings.cancelButton),
                  ),
                  FilledButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save),
                    label: const Text(AppStrings.saveButton),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Campo de solo lectura que abre un selector (fecha u hora) al pulsarlo.
class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        child: Text(value),
      ),
    );
  }
}
