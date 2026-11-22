import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Guarda el token de sesión cifrado en el almacenamiento interno del móvil
class SecureStorageService {
  SecureStorageService._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _tokenKey = 'session_token';

  static Future<void> saveToken(String token) => _storage.write(key: _tokenKey, value: token);

  static Future<String?> getToken() => _storage.read(key: _tokenKey);

  static Future<void> deleteToken() => _storage.delete(key: _tokenKey);
  
}