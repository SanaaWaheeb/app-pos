import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "ava.sa/app-pos";

  // Fetch products based on board id
  static Future<List<dynamic>> fetchProducts(String boardId) async {
    final response = await http.get(Uri.parse("$baseUrl/products/$boardId"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }

  // Fetch machine id and user id based on board id
  static Future<Map<String, dynamic>?> fetchMachineDetails(
      String boardId) async {
    final response =
        await http.get(Uri.parse("$baseUrl/machine-details/$boardId"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
