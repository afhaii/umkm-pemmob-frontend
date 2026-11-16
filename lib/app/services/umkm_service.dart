import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/umkm_model.dart';

class UmkmService {
  final String baseUrl = 'http://localhost:8080/api';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Memeriksa response dari server
  Map<String, dynamic> _handleResponse(http.Response response) {
    final decoded = jsonDecode(response.body);

    if (decoded is! Map<String, dynamic>) {
      throw Exception('Format response tidak valid');
    }

    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        decoded['success'] != true) {
      throw Exception(decoded['message'] ?? 'Request gagal');
    }

    return decoded;
  }

  // GET: Mengambil seluruh data UMKM
  Future<List<Umkm>> getUmkmList() async {
    final response = await http
        .get(Uri.parse('$baseUrl/umkm'), headers: headers)
        .timeout(const Duration(seconds: 15));

    final result = _handleResponse(response);
    final List<dynamic> data = result['data'];

    return data.map((item) => Umkm.fromJson(item)).toList();
  }

  // POST: Menambahkan UMKM
  Future<Map<String, dynamic>> createUmkm(Umkm umkm) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/umkm'),
          headers: headers,
          body: jsonEncode(umkm.toJson()),
        )
        .timeout(const Duration(seconds: 15));

    return _handleResponse(response);
  }

  // PUT: Memperbarui UMKM
  Future<Map<String, dynamic>> updateUmkm(int id, Umkm umkm) async {
    final response = await http
        .put(
          Uri.parse('$baseUrl/umkm/$id'),
          headers: headers,
          body: jsonEncode(umkm.toJson()),
        )
        .timeout(const Duration(seconds: 15));

    return _handleResponse(response);
  }

  // DELETE: Menghapus UMKM
  Future<Map<String, dynamic>> deleteUmkm(int id) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/umkm/$id'), headers: headers)
        .timeout(const Duration(seconds: 15));

    return _handleResponse(response);
  }
}
