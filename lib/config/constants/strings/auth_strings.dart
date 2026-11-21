/// Textos de las pantallas de inicio de sesión y registro.
class AuthStrings {
  AuthStrings._();

  // Campos
  static const String fullNameLabel = 'Nombre completo';
  static const String emailLabel = 'Correo electrónico';
  static const String passwordLabel = 'Contraseña';
  static const String passwordHelper =
      'Mínimo 8 caracteres, con mayúscula, minúscula, número y símbolo';
  static const String showPassword = 'Mostrar contraseña';
  static const String hidePassword = 'Ocultar contraseña';

  // Errores de validación
  static const String fullNameError = 'Escribe tu nombre y al menos un apellido';
  static const String emailError = 'Escribe un correo válido, como nombre@correo.com';
  static const String passwordLengthError = 'Debe tener al menos 8 caracteres';
  static const String passwordUppercaseError = 'Debe tener al menos una mayúscula';
  static const String passwordLowercaseError = 'Debe tener al menos una minúscula';
  static const String passwordNumberError = 'Debe tener al menos un número';
  static const String passwordSymbolError = 'Debe tener al menos un símbolo, como ! o @';

  // Errores de conexión
  static const String timeoutError =
      'El servidor ha tardado demasiado en responder. Inténtalo de nuevo.';
  static const String connectionError =
      'No se ha podido conectar con el servidor. Revisa tu conexión a internet.';
  static const String unknownError = 'El servidor ha respondido sin ningún mensaje.';
  static const String noSession = 'No hay ninguna sesión iniciada.';
}
