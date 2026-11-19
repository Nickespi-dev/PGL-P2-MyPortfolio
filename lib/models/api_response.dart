/// Resultado de una llamada a la API: si ha ido bien y el mensaje para el usuario.
class ApiResponse {
  const ApiResponse({required this.isSuccess, required this.message});

  final bool isSuccess;
  final String message;
}