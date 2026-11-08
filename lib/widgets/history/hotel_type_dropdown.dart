import 'package:flutter/material.dart';
import 'package:my_portfolio/config/constants/strings/record_form_strings.dart';
import 'package:my_portfolio/models/hotel_type.dart';

/// Selector del tipo de hotel del formulario, con el icono de cada tipo.
class HotelTypeDropdown extends StatelessWidget {
  const HotelTypeDropdown({super.key, required this.value, required this.onChanged});

  final HotelType? value;
  final ValueChanged<HotelType?> onChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return DropdownButtonFormField<HotelType>(
      initialValue: value,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: RecordFormStrings.hotelTypeLabel,
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
      onChanged: onChanged,
      validator: (type) => type == null ? RecordFormStrings.chooseHotelType : null,
    );
  }
}
