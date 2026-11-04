import 'package:flutter/material.dart';

/// Funciones para mostarr fechas, horas y duraciones con formato español
class Formatters {
  Formatters._();

  static String _twoDigits(int number) => number.toString().padLeft(2, '0');

  static String date(DateTime date) =>
      '${_twoDigits((date.day))}/${_twoDigits(date.month)}/${date.year}';

  static String time(TimeOfDay time) => '${(_twoDigits(time.hour))}:${_twoDigits(time.minute)}';

  static String duration(int minutes) {
    final int hours = minutes ~/ 60;
    final int rest = minutes % 60;
    return rest == 0 ? '$hours h' : '$hours h $rest min';
  }
}
