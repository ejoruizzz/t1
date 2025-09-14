import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import 'api_service.dart';

class AuthService extends ChangeNotifier {
  static const _storage = FlutterSecureStorage();
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;

  // Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/auth/login'),
        headers: ApiService.getHeaders(),
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final data = await ApiService.handleResponse(response);
      _currentUser = User.fromJson(data);
      
      // Guardar tokens de forma segura
      await _storage.write(key: 'access_token', value: _currentUser!.accessToken);
      await _storage.write(key: 'refresh_token', value: _currentUser!.refreshToken);
      await _storage.write(key: 'user_data', value: json.encode(_currentUser!.toJson()));
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    _currentUser = null;
    await _storage.deleteAll();
    notifyListeners();
  }

  // Verificar si hay sesión guardada
  Future<bool> checkAuthStatus() async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      final userData = await _storage.read(key: 'user_data');
      
      if (accessToken != null && userData != null) {
        _currentUser = User.fromJson(json.decode(userData));
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Refresh token (implementar cuando tengas el endpoint)
  Future<bool> refreshToken() async {
    try {
      final refreshToken = await _storage.read(key: 'refresh_token');
      if (refreshToken == null) return false;

      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/auth/refresh'),
        headers: ApiService.getHeaders(),
        body: json.encode({'refreshToken': refreshToken}),
      );

      final data = await ApiService.handleResponse(response);
      _currentUser = User.fromJson(data);
      
      await _storage.write(key: 'access_token', value: _currentUser!.accessToken);
      await _storage.write(key: 'user_data', value: json.encode(_currentUser!.toJson()));
      
      notifyListeners();
      return true;
    } catch (e) {
      await logout();
      return false;
    }
  }

  // Obtener token actual
  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }
}
