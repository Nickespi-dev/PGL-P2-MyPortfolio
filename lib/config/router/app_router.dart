import 'package:go_router/go_router.dart';
import 'package:my_portfolio/config/router/app_routes.dart';
import 'package:my_portfolio/screens/portfolio/portfolio_screen.dart';
import 'package:my_portfolio/screens/welcome/welcome_screen.dart';

/// Configuración de la navegación: qué pantalla se abre en cada ruta.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(path: AppRoutes.welcome, builder: (context, state) => const WelcomeScreen()),
    // Las dos secciones del portfolio, sin animación al cambiar entre ellas.
    GoRoute(
      path: AppRoutes.hobbies,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: PortfolioScreen(selectedIndex: 0)),
    ),
    GoRoute(
      path: AppRoutes.aboutMe,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: PortfolioScreen(selectedIndex: 1)),
    ),
  ],
);
