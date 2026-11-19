/// Textos de las pantallas de inicio de sesión y registro.
class AuthStrings {
  AuthStrings._();

  // Errores de conexión
  static const String timeoutError =
      'El servidor ha tardado demasiado en responder. Inténtalo de nuevo.';
  static const String connectionError =
      'No se ha podido conectar con el servidor. Revisa tu conexión a internet.';
  static const String unknownError = 'El servidor ha respondido sin ningún mensaje.';
  static const String noSession = 'No hay ninguna sesión iniciada.';
}