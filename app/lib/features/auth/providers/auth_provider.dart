import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recom24/features/auth/models/auth_models.dart';
import 'package:recom24/features/auth/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  String? _token;
  bool _isLoading = false;

  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  AuthProvider() {
    _loadAuthData();
  }

  Future<void> _loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('access_token');
    // In a real app, you might also load user data or verify the token
    notifyListeners();
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String profession,
  }) async {
    _setLoading(true);
    try {
      final response = await _authService.signUp(
        email: email,
        password: password,
        name: name,
        profession: profession,
      );
      await _handleAuthSuccess(response);
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      final response = await _authService.signIn(
        email: email,
        password: password,
      );
      await _handleAuthSuccess(response);
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _handleAuthSuccess(AuthResponse response) async {
    _user = response.user;
    _token = response.accessToken;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', _token!);
    
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
