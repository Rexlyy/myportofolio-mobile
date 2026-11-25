import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ApiClient {
  final String baseUrl;

  ApiClient({this.baseUrl = apiBaseUrl});

  Future<List<Project>> getProjects() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/projects/'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => Project.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load projects: ${response.statusCode}');
    }
  }

  Future<String> obtainToken(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/token/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token'] as String;
    } else {
      throw Exception('Login failed: ${response.statusCode}');
    }
  }

  Future<void> logout({required String token}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/logout/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Logout failed: ${response.statusCode}');
    }
  }

  Future<Project> createProject(
    Project project, {
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/projects/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(project.toJson()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Project.fromJson(data as Map<String, dynamic>);
    } else {
      throw Exception(
        'Failed to create project: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
