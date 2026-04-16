import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recom24/core/config/api_config.dart';
import 'package:recom24/features/auth/models/auth_models.dart';

class AuthService {
  final http.Client _client = http.Client();

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
    required String profession,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.signUp}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
          'profession': profession,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(jsonDecode(response.body));
      } else {
        final error = jsonDecode(response.body)['detail'] ?? 'Registration failed';
        throw Exception(error);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.signIn}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));
      } else {
        final error = jsonDecode(response.body)['detail'] ?? 'Login failed';
        throw Exception(error);
      }
    } catch (e) {
      rethrow;
    }
  }
}
