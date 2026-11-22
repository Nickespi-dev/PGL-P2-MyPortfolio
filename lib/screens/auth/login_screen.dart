import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/config/constants/strings/auth_strings.dart';
import 'package:my_portfolio/config/router/app_routes.dart';
import 'package:my_portfolio/models/api_response.dart';
import 'package:my_portfolio/services/auth_service.dart';
import 'package:my_portfolio/utils/validators.dart';
import 'package:my_portfolio/widgets/auth/auth_header.dart';
import 'package:my_portfolio/widgets/auth/email_field.dart';
import 'package:my_portfolio/widgets/auth/password_field.dart';
import 'package:my_portfolio/widgets/common/loading_button.dart';
import 'package:my_portfolio/widgets/common/message_dialog.dart';

/// Pantalla de inicio de sesión. Es la primera que se ve al abrir la app.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isCheckingSession = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSavedSession();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Sesión guardada: si el token sigue siendo válido, se entra directamente.
  Future<void> _checkSavedSession() async {
    final bool isValid = await AuthService.checkSavedToken();
    if (!mounted) return;

    if (isValid) {
      context.go(AppRoutes.welcome);
    } else {
      setState(() => _isCheckingSession = false);
    }
  }

  // Iniciar sesión
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    final ApiResponse response = await AuthService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    await MessageDialog.show(context, message: response.message, isSuccess: response.isSuccess);
    if (!mounted || !response.isSuccess) return;
    context.go(AppRoutes.welcome);
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingSession) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [CircularProgressIndicator(), Text(AuthStrings.checkingSession)],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  const AuthHeader(
                    title: AuthStrings.loginTitle,
                    subtitle: AuthStrings.loginSubtitle,
                  ),
                  const SizedBox(height: 8),
                  EmailField(controller: _emailController),
                  PasswordField(
                    controller: _passwordController,
                    validator: Validators.requiredPassword,
                  ),
                  LoadingButton(
                    label: AuthStrings.loginButton,
                    icon: Icons.login,
                    isLoading: _isLoading,
                    onPressed: _login,
                  ),

                  // Ir al registro
                  TextButton(
                    onPressed: _isLoading ? null : () => context.push(AppRoutes.register),
                    child: const Text(AuthStrings.goToRegister),
                  ),
                  Text(
                    AuthStrings.serverWakeUpNote,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).hintColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}