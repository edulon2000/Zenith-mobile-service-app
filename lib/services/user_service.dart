import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  final String _baseUrl = "http://10.0.2.2:8080/api";
  final _storage = const FlutterSecureStorage();

  Future<UserModel> getMyProfile() async {
    print("--- [DEBUG] Iniciando getMyProfile ---");

    final token = await _storage.read(key: 'authToken');

    print("[DEBUG] Token lido do storage: ${token ?? 'TOKEN NULO'}");

    if (token == null) {
      throw Exception('Token não encontrado, faça o login novamente.');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // PRINT 2: A requisição está sendo montada corretamente?
    print("[DEBUG] Enviando requisição para: $_baseUrl/users/me");
    print("[DEBUG] Cabeçalhos enviados: $headers");

    final response = await http.get(
      Uri.parse('$_baseUrl/users/me'),
      headers: headers,
    );

    // PRINT 3: Qual foi a resposta exata do backend?
    print("[DEBUG] Resposta do Backend - Status: ${response.statusCode}");
    print("[DEBUG] Resposta do Backend - Corpo: ${response.body}");
    print("--- [DEBUG] Finalizando getMyProfile ---");


    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar o perfil do usuário.');
    }
  }
}