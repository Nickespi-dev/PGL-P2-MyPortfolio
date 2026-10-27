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
  static const String moodleUrl =
      'https://aulasalesianoslacuesta.com/mod/assign/view.php?id=25191';
  static const String copyLinkButton = 'Copiar enlace a Moodle';
  static const String linkCopied = 'Enlace copiado al portapapeles';
}
