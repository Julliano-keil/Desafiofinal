import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> carsBrands() async {
  final response = await http
      .get(Uri.parse('https://parallelum.com.br/fipe/api/v2/cars/brands'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((brand) => brand['name'] as String).toList();
  } else {
    throw Exception('Failed to load car brands');
  }
}

Future<List<String>> motorcyclesBrands() async {
  final response = await http.get(
      Uri.parse('https://parallelum.com.br/fipe/api/v2/motorcycles/brands'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((brand) => brand['name'] as String).toList();
  } else {
    throw Exception('Failed to load car brands');
  }
}

Future<List<String>> trucksBrands() async {
  final response = await http
      .get(Uri.parse('https://parallelum.com.br/fipe/api/v2/trucks/brands'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((brand) => brand['name'] as String).toList();
  } else {
    throw Exception('Failed to load car brands');
  }
}
