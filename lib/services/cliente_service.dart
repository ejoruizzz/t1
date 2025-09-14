import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cliente.dart';
import 'api_service.dart';
import 'auth_service.dart';

class ClienteService extends ChangeNotifier {
  List<Cliente> _clientes = [];
  bool _isLoading = false;
  String? _error;
  final AuthService _authService = AuthService();

  List<Cliente> get clientes => _clientes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Obtener todos los clientes
  Future<bool> getAllClientes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.getAccessToken();
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/clientes'),
        headers: ApiService.getHeaders(token: token),
      );

      final data = await ApiService.handleResponse(response);
      
      // La respuesta es directamente un array de clientes
      if (data is List) {
        _clientes = data.map((json) => Cliente.fromJson(json)).toList();
      } else {
        // Si fuera un objeto que contiene la lista
        _clientes = (data['clientes'] as List).map((json) => Cliente.fromJson(json)).toList();
      }
      
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

  // Crear cliente
  Future<bool> createCliente(Cliente cliente) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.getAccessToken();
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/clientes'),
        headers: ApiService.getHeaders(token: token),
        body: json.encode(cliente.toJson()),
      );

      final data = await ApiService.handleResponse(response);
      
      // La respuesta puede ser el cliente creado directamente
      Cliente newCliente;
      if (data is Map<String, dynamic>) {
        newCliente = Cliente.fromJson(data);
      } else {
        // Si la respuesta tiene estructura diferente, manejarla aquí
        newCliente = Cliente.fromJson(data);
      }
      
      _clientes.add(newCliente);
      
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

  // Actualizar cliente
  Future<bool> updateCliente(int id, Cliente cliente) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.getAccessToken();
      final response = await http.put(
        Uri.parse('${ApiService.baseUrl}/clientes/$id'),
        headers: ApiService.getHeaders(token: token),
        body: json.encode(cliente.toJson()),
      );

      final data = await ApiService.handleResponse(response);
      
      // La respuesta puede ser el cliente actualizado
      Cliente updatedCliente;
      if (data is Map<String, dynamic>) {
        updatedCliente = Cliente.fromJson(data);
      } else {
        updatedCliente = cliente.copyWith(id: id);
      }
      
      final index = _clientes.indexWhere((c) => c.id == id);
      if (index != -1) {
        _clientes[index] = updatedCliente;
      }
      
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

  // Eliminar cliente
  Future<bool> deleteCliente(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.getAccessToken();
      final response = await http.delete(
        Uri.parse('${ApiService.baseUrl}/clientes/$id'),
        headers: ApiService.getHeaders(token: token),
      );

      await ApiService.handleResponse(response);
      _clientes.removeWhere((c) => c.id == id);
      
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

  // Obtener cliente por ID
  Future<Cliente?> getClienteById(int id) async {
    try {
      final token = await _authService.getAccessToken();
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/clientes/$id'),
        headers: ApiService.getHeaders(token: token),
      );

      final data = await ApiService.handleResponse(response);
      
      if (data is Map<String, dynamic>) {
        return Cliente.fromJson(data);
      }
      return null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
}