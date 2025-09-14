import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';
import 'api_service.dart';
import 'auth_service.dart';

class ProductService extends ChangeNotifier {
  final AuthService _authService = AuthService();
  List<Product> _productos = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get productos => _productos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> getAllProductos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.getAccessToken();
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/productos'),
        headers: ApiService.getHeaders(token: token),
      );

      final data = await ApiService.handleResponse(response);
      if (data is List) {
        _productos = data.map((json) => Product.fromJson(json)).toList();
      } else {
        _productos = (data['productos'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
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

  Future<bool> createProducto(Product producto) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.getAccessToken();
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/productos'),
        headers: ApiService.getHeaders(token: token),
        body: json.encode(producto.toJson()),
      );

      final data = await ApiService.handleResponse(response);
      final newProducto = Product.fromJson(data);
      _productos.add(newProducto);

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

  Future<bool> updateProducto(int id, Product producto) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.getAccessToken();
      final response = await http.put(
        Uri.parse('${ApiService.baseUrl}/productos/$id'),
        headers: ApiService.getHeaders(token: token),
        body: json.encode(producto.toJson()),
      );

      final data = await ApiService.handleResponse(response);
      final updatedProducto = Product.fromJson(data);
      final index = _productos.indexWhere((p) => p.id == id);
      if (index != -1) {
        _productos[index] = updatedProducto;
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

  Future<bool> deleteProducto(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.getAccessToken();
      final response = await http.delete(
        Uri.parse('${ApiService.baseUrl}/productos/$id'),
        headers: ApiService.getHeaders(token: token),
      );

      await ApiService.handleResponse(response);
      _productos.removeWhere((p) => p.id == id);

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

  Future<Product?> getProductoById(int id) async {
    try {
      final token = await _authService.getAccessToken();
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/productos/$id'),
        headers: ApiService.getHeaders(token: token),
      );

      final data = await ApiService.handleResponse(response);
      if (data is Map<String, dynamic>) {
        return Product.fromJson(data);
      }
      return null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
}
