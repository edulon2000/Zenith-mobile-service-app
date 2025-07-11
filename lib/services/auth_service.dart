import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // Use '10.0.2.2' para emulador Android se 'localhost' não funcionar.
  // Se for celular físico, use o IP da sua máquina na rede (ex: 192.168.1.5).
  final String _baseUrl = "http://10.0.2.2:8080/auth";
  final _storage = const FlutterSecureStorage();

  // Para login com email/senha (que você pode reativar depois)
  Future<String?> login(String email, String password) async {
    // Implementação do login com senha, se necessário
    return null;
  }

  // Método para o login com Google
  Future<String?> syncWithGoogle(String googleIdToken) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/google'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id_token': googleIdToken}),
    );

    if (response.statusCode == 200) {
      // O backend agora só retorna dados do usuário, não mais um token.
      // O token a ser guardado é o próprio `googleIdToken`.
      await _saveToken(googleIdToken);
      return googleIdToken;
    } else {
      throw Exception('Falha ao sincronizar com o backend');
    }
  }

  Future<void> _saveToken(String token) async {
    await _storage.write(key: 'authToken', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'authToken');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'authToken');
  }
}