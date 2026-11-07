/// Textos de la pantalla del historial: lista, marcador y borrado.
class HistoryStrings {
  HistoryStrings._();

  // Pantalla
  static const String title = 'Historial de fichajes';
  static const String emptyHistory =
      'Todavía no hay fichajes.\nPulsa «Añadir fichaje» para crear el primero.';
  static const String addRecordButton = 'Añadir fichaje';

  // Marcador
  static const String recordsCounter = 'Fichajes registrados';
  static const String hoursCounter = 'Horas totales';

  // Borrar un fichaje
  static const String deleteRecordTooltip = 'Borrar fichaje';
  static const String deleteRecordTitle = '¿Borrar este fichaje?';
  static const String deleteRecordConfirm = 'Borrar';
  static const String recordDeleted = 'Fichaje borrado';

  // Borrar todos los fichajes
  static const String deleteAllTooltip = 'Borrar todos los fichajes';
  static const String deleteAllTitle = '¿Borrar todos los fichajes?';
  static const String deleteAllMessage =
      'Se borrarán todos los fichajes del historial. Esta acción no se puede deshacer.';
  static const String deleteAllConfirm = 'Borrar todo';
  static const String allRecordsDeleted = 'Se han borrado todos los fichajes';
}
