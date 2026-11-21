import 'package:go_router/go_router.dart';
import 'package:my_portfolio/config/router/app_routes.dart';
import 'package:my_portfolio/screens/auth/login_screen.dart';
import 'package:my_portfolio/screens/auth/register_screen.dart';
import 'package:my_portfolio/screens/history/history_screen.dart';
import 'package:my_portfolio/screens/portfolio/portfolio_screen.dart';
import 'package:my_portfolio/screens/welcome/welcome_screen.dart';
import 'package:my_portfolio/services/auth_service.dart';

/// Configuración de la navegación: qué pantalla se abre en cada ruta.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  // Sin sesión, solo se puede estar en el login o en el registro.
  redirect: (context, state) {
    final bool isAuthRoute =
        state.matchedLocation == AppRoutes.login || state.matchedLocation == AppRoutes.register;
    if (!AuthService.isLoggedIn && !isAuthRoute) return AppRoutes.login;
    return null;
  },
  routes: [
    GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
    GoRoute(path: AppRoutes.register, builder: (context, state) => const RegisterScreen()),
    GoRoute(path: AppRoutes.welcome, builder: (context, state) => const WelcomeScreen()),
    GoRoute(path: AppRoutes.portfolio, builder: (context, state) => const PortfolioScreen()),
    GoRoute(path: AppRoutes.history, builder: (context, state) => const HistoryScreen()),
  ],
);