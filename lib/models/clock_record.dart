import 'package:flutter/material.dart';
import 'package:my_portfolio/models/hotel_type.dart';

/// Un fichaje: en qué hotel, de que tipo, qué día y a que horas.
class ClockRecord {
  const ClockRecord({
    required this.hotelName,
    required this.description,
    required this.hotelType,
    required this.date,
    required this.entry,
    required this.exit,
  });

  final String hotelName;
  final String description;
  final HotelType hotelType;
  final DateTime date;
  final TimeOfDay entry;
  final TimeOfDay exit;

  /// Minutos trabajados. Si la salida es anterior a la entrada
  /// es un turno de noche que termina al dia siguiente.
  int get workedMinutes {
    final int start = entry.hour * 60 + entry.minute;
    final int end = exit.hour * 60 + exit.minute;
    return end >= start ? end - start : end + 24 * 60 - start;
  }
}
