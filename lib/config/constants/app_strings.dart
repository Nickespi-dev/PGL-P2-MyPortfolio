/// Textos, rutas de imágenes y enlaces que se muestran en la app.
class AppStrings {
  AppStrings._(); // Constructor privado: esta clase no se instancia

  // Cabecera
  static const String appTitle = 'Portfolio de Nick';
  static const String lifeQuote = 'Vida solo hay una. Carpe diem.';
  static const String profileImage = 'assets/images/profile_photo.gif';

  // Pestaña de hobbies
  static const String hobbiesTab = 'Mis hobbies';
  static const List<String> hobbies = [
    'Salir con Nala',
    'Salir con Kaiser',
    'Salir con los dos',
    'One Piece',
    'Hacer mods Skyrim',
    'Mundiales del Lol',
    'Basket',
    'Fútbol',
    'Skyrim',
    'LOL',
    'Estudiar',
    'Limpiar',
    'Anime',
    'Música',
  ];
  // Menú lateral
  static const String drawerName = 'Nick Espinoza';
  static const String drawerSubtitle = 'Easy Check · 2.º DAM';
  static const String portfolioMenu = 'Portfolio';

  // Pestaña "Sobre mí"
  static const String aboutMeTab = 'Sobre mí';
  static const String aboutMeImage = 'assets/images/nala_kaiser.jpg';
  static const String aboutMeText =
      'Hola, soy Nick, estudiante de 2º DAM. Me gusta el anime y los '
      'videojuegos, sobre todo aquellos en los que puedes crear mods, como '
      'Skyrim o Sekiro. También me gusta aprender cosas nuevas y estudiar. '
      'Y mi prioridad son mi familia y mis perros.';
  static const String moodleUrl = 'https://aulasalesianoslacuesta.com/mod/assign/view.php?id=25191';
  static const String copyLinkButton = 'Copiar enlace a Moodle';
  static const String linkCopied = 'Enlace copiado al portapapeles';

  // Pantalla de bienvenida
  static const String appName = 'Easy Check';
  static const String welcomeBackground = 'assets/images/welcome_background.png';
  static const String welcomeTitle = 'Bienvenido a\nEasy Check';
  static const String welcomeMessage =
      'Registra tu jornada en los hoteles de Canarias de forma rápida, '
      'segura y sin papel.';
  static const String enterButton = 'Entrar';
  static const String location = 'Islas Canarias';
  static const String welcomeMenu = 'Inicio';

  // Historial de fichajes
  static const String historyMenu = 'Historial';
  static const String historyTitle = 'Historial de fichajes';
  static const String recordsCounter = 'Fichajes registrados';
  static const String hoursCounter = 'Horas totales';
  static const String emptyHistory =
      'Todavía no hay fichajes.\nPulsa «Añadir fichaje» para crear el primero.';
  static const String addRecordButton = 'Añadir fichaje';
  static const String deleteRecordTooltip = 'Borrar fichaje';
  static const String recordDeleted = 'Fichaje borrado';
  // Modal para añadir un fichaje
  static const String addRecordTitle = 'Añadir fichaje';
  static const String hotelNameLabel = 'Nombre del hotel';
  static const String descriptionLabel = 'Descripción breve';
  static const String hotelTypeLabel = 'Tipo de hotel';
  static const String dateLabel = 'Fecha';
  static const String entryLabel = 'Entrada';
  static const String exitLabel = 'Salida';
  static const String requiredField = 'Este campo es obligatorio';
  static const String chooseHotelType = 'Elige el tipo de hotel';
  static const String cancelButton = 'Cancelar';
  static const String saveButton = 'Guardar';

  // Borrar fichajes
  static const String deleteRecordTitle = '¿Borrar este fichaje?';
  static const String deleteRecordConfirm = 'Borrar';
  static const String deleteAllTooltip = 'Borrar todos los fichajes';
  static const String deleteAllTitle = '¿Borrar todos los fichajes?';
  static const String deleteAllMessage =
      'Se borrarán todos los fichajes del historial. Esta acción no se puede deshacer.';
  static const String deleteAllConfirm = 'Borrar todo';
  static const String allRecordsDeleted = 'Se han borrado todos los fichajes';
}
