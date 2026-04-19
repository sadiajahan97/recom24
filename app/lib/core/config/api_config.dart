import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get baseUrl => dotenv.get('API_BASE_URL', fallback: 'http://localhost:8004');
  static const String signUp = '/auth/sign-up';
  static const String signIn = '/auth/sign-in';
}
