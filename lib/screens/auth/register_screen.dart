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

/// Pantalla de registro de un usuario nuevo.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Registrarse
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    final ApiResponse response = await AuthService.register(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    await MessageDialog.show(context, message: response.message, isSuccess: response.isSuccess);
    if (!mounted || !response.isSuccess) return;
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  const AuthHeader(
                    title: AuthStrings.registerTitle,
                    subtitle: AuthStrings.registerSubtitle,
                  ),
                  const SizedBox(height: 8),

                  // Nombre completo
                  TextFormField(
                    controller: _fullNameController,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: AuthStrings.fullNameLabel,
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: Validators.fullName,
                  ),
                  EmailField(controller: _emailController),
                  PasswordField(
                    controller: _passwordController,
                    validator: Validators.strongPassword,
                    helperText: AuthStrings.passwordHelper,
                  ),
                  LoadingButton(
                    label: AuthStrings.registerButton,
                    icon: Icons.person_add,
                    isLoading: _isLoading,
                    onPressed: _register,
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