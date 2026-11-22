/// Textos de las pantallas de inicio de sesión y registro.
class AuthStrings {
  AuthStrings._();

  // Inicio de sesión
  static const String loginTitle = 'Hola de nuevo';
  static const String loginSubtitle = 'Inicia sesión para registrar tu jornada.';
  static const String loginButton = 'Iniciar sesión';
  static const String goToRegister = '¿No tienes cuenta? Regístrate';
  static const String checkingSession = 'Comprobando tu sesión…';
  static const String serverWakeUpNote =
      'La primera petición puede tardar hasta un minuto mientras el servidor se activa.';

  // Registro
  static const String registerTitle = 'Crear cuenta';
  static const String registerSubtitle = 'Regístrate para empezar a usar Easy Check.';
  static const String registerButton = 'Registrarme';

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