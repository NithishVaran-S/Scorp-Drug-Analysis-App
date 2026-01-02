import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000";

  // Get Drug Interactions
  Future<Map<String, dynamic>> getDrugInteractions(List<String> drugs) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/analyze_interactions/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"drugs": drugs}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Failed to fetch drug interactions"};
      }
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  // Get Dosage & Side Effects
  Future<Map<String, dynamic>> getDosageAndSideEffects(String drugName, int age) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/get_dosage_and_side_effects/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"drug_name": drugName, "age": age}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Failed to fetch dosage & side effects"};
      }
    } catch (e) {
      return {"error": e.toString()};
    }
  }
}
