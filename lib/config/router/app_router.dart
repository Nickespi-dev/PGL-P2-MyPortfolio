import 'package:go_router/go_router.dart';
import 'package:my_portfolio/config/router/app_routes.dart';
import 'package:my_portfolio/screens/portfolio_screen.dart';

/// Configuración de la navegación: qué pantalla se abre en cada ruta.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.portfolio,
  routes: [
    GoRoute(
      path: AppRoutes.portfolio,
      builder: (context, state) => const PortfolioScreen(),
    ),
  ],
);