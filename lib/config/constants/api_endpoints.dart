class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://my-users-api.onrender.com';

  static const String register = '$baseUrl/users/register';
  static const String login = '$baseUrl/users/login';
  static const String checkToken = '$baseUrl/users/check-token';
  static const String welcome = '$baseUrl/users/welcome';

  
}