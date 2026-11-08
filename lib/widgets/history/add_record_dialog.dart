import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/common_strings.dart';
import 'package:my_portfolio/config/constants/strings/record_form_strings.dart';
import 'package:my_portfolio/models/clock_record.dart';
import 'package:my_portfolio/models/hotel_type.dart';
import 'package:my_portfolio/utils/formatters.dart';
import 'package:my_portfolio/widgets/common/picker_field.dart';
import 'package:my_portfolio/widgets/history/hotel_type_dropdown.dart';

/// Modal con el formulario para añadir un fichaje.
class AddRecordDialog extends StatefulWidget {
  const AddRecordDialog({super.key});

  @override
  State<AddRecordDialog> createState() => _AddRecordDialogState();
}

class _AddRecordDialogState extends State<AddRecordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hotelController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  HotelType? _hotelType;
  DateTime _date = DateTime.now();
  TimeOfDay _entry = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _exit = const TimeOfDay(hour: 16, minute: 0);

  @override
  void dispose() {
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

  String? _requiredText(String? value) =>
      (value == null || value.trim().isEmpty) ? CommonStrings.requiredField : null;

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final ClockRecord record = ClockRecord(
      hotelName: _hotelController.text.trim(),
      description: _descriptionController.text.trim(),
      hotelType: _hotelType!,
      date: _date,
      entry: _entry,
      exit: _exit,
    );
    Navigator.pop(context, record);
  }

  @override
  Widget build(BuildContext context) {
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
              Text(RecordFormStrings.title, style: Theme.of(context).textTheme.titleLarge),

              // Nombre
              TextFormField(
                controller: _hotelController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: RecordFormStrings.hotelNameLabel,
                  prefixIcon: Icon(Icons.hotel),
                  border: OutlineInputBorder(),
                ),
                validator: _requiredText,
              ),

              // Descripción breve
              TextFormField(
                controller: _descriptionController,
                maxLength: 60,
                decoration: const InputDecoration(
                  labelText: RecordFormStrings.descriptionLabel,
                  prefixIcon: Icon(Icons.notes),
                  border: OutlineInputBorder(),
                ),
                validator: _requiredText,
              ),

              // Tipo de hotel
              HotelTypeDropdown(
                value: _hotelType,
                onChanged: (type) => setState(() => _hotelType = type),
              ),

              // Fecha y horas
              PickerField(
                label: RecordFormStrings.dateLabel,
                value: Formatters.date(_date),
                icon: Icons.calendar_today,
                onTap: _pickDate,
              ),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: PickerField(
                      label: RecordFormStrings.entryLabel,
                      value: Formatters.time(_entry),
                      icon: Icons.login,
                      onTap: () => _pickTime(isEntry: true),
                    ),
                  ),
                  Expanded(
                    child: PickerField(
                      label: RecordFormStrings.exitLabel,
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
                    onPressed: () => Navigator.pop(context),
                    child: const Text(CommonStrings.cancelButton),
                  ),
                  FilledButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save),
                    label: const Text(CommonStrings.saveButton),
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
