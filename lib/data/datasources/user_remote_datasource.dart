import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserRemoteDatasource {
  final String _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

  UserRemoteDatasource();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error en el login: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String userId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fallo al obtener la información del usuario: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateUser(String userId, String? username, String? avatar) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/$userId/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'avatar': avatar}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fallo al actualizar la información del usuario: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> followUser(String userId, String followerId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/$followerId/follow'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'followerId': userId}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fallo al intentar añadir un seguidor: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getAllUsers() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fallo al obtener la información de los usuarios: ${response.body}');
    }
  }
}
