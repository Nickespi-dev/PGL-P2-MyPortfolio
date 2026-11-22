import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_portfolio/config/constants/api_endpoints.dart';
import 'package:my_portfolio/config/constants/strings/auth_strings.dart';
import 'package:my_portfolio/models/api_response.dart';
import 'package:my_portfolio/services/secure_storage_service.dart';

/// Peticiones HTTP a la API de usuarios: registro, login, token y bienvenida.
class AuthService {
  AuthService._();

  // Render tarda hasta un minuto en despertar la API si estaba en reposo.
  static const Duration _timeout = Duration(seconds: 90);
  static const Map<String, String> _jsonHeaders = {'Content-Type': 'application/json'};

  /// Indica si en esta ejecución hay una sesión comprobada. Lo usa el router.
  static bool isLoggedIn = false;

  // Registro
  static Future<ApiResponse> register({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _send(
      http.post(
        Uri.parse(ApiEndpoints.register),
        headers: _jsonHeaders,
        body: jsonEncode({'fullName': fullName, 'email': email, 'pwd': password}),
      ),
    );
  }

  // Inicio de sesión
  static Future<ApiResponse> login({required String email, required String password}) {
    return _send(
      http.post(
        Uri.parse(ApiEndpoints.login),
        headers: _jsonHeaders,
        body: jsonEncode({'email': email, 'pwd': password}),
      ),
      onSuccess: (body) async {
        await SecureStorageService.saveToken(body['token'] as String);
        isLoggedIn = true;
      },
    );
  }

  // Comprobar el token guardado
  static Future<bool> checkSavedToken() async {
    final String? token = await SecureStorageService.getToken();
    if (token == null) return false;

    final ApiResponse response = await _send(
      http.get(Uri.parse(ApiEndpoints.checkToken), headers: _authHeaders(token)),
    );
    isLoggedIn = response.isSuccess;
    return response.isSuccess;
  }

  // Mensaje de bienvenida
  static Future<ApiResponse> getWelcomeMessage() async {
    final String? token = await SecureStorageService.getToken();
    if (token == null) {
      return const ApiResponse(isSuccess: false, message: AuthStrings.noSession);
    }

    return _send(http.get(Uri.parse(ApiEndpoints.welcome), headers: _authHeaders(token)));
  }

  // Cerrar sesión
  static Future<void> logout() async {
    await SecureStorageService.deleteToken();
    isLoggedIn = false;
  }

  static Map<String, String> _authHeaders(String token) => {'Authorization': 'Bearer $token'};

  /// Espera la respuesta, lee su mensaje y convierte cualquier fallo en un ApiResponse.
  static Future<ApiResponse> _send(
    Future<http.Response> request, {
    Future<void> Function(Map<String, dynamic> body)? onSuccess,
  }) async {
    try {
      final http.Response response = await request.timeout(_timeout);
      final Map<String, dynamic> body = _decodeBody(response.body);
      final bool isSuccess = response.statusCode >= 200 && response.statusCode < 300;

      if (isSuccess && onSuccess != null) await onSuccess(body);

      return ApiResponse(
        isSuccess: isSuccess,
        message: body['message'] as String? ?? AuthStrings.unknownError,
      );
    } on TimeoutException {
      return const ApiResponse(isSuccess: false, message: AuthStrings.timeoutError);
    } catch (_) {
      return const ApiResponse(isSuccess: false, message: AuthStrings.connectionError);
    }
  }

  /// Convierte el texto JSON en un mapa. Si no es JSON, devuelve un mapa vacío.
  static Map<String, dynamic> _decodeBody(String body) {
    try {
      final Object? data = jsonDecode(body);
      return data is Map<String, dynamic> ? data : <String, dynamic>{};
    } on FormatException {
      return <String, dynamic>{};
    }
  }
}