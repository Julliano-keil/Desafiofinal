import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

/// Parses the JSON response and returns a list of ModelEndpoint objects.
List<ModelEndpoint> fipeApiFromJson(String str) =>
    List<ModelEndpoint>.from(json.decode(str).map(ModelEndpoint.fromJson));

/// Converts a list of ModelEndpoint objects to a JSON string.
String fipeApiToJson(List<ModelEndpoint> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// Represents a car brand retrieved from the API.
class BrandEndpoint {
  ///
  final String? code;

  ///
  final String? name;

  /// Creates a [BrandEndpoint] from JSON data.
  BrandEndpoint({
    this.code,
    this.name,
  });

  /// Parses JSON data to create a [BrandEndpoint] instance.
  factory BrandEndpoint.fromJson(Map<String, dynamic> json) => BrandEndpoint(
        code: json['codigo'],
        name: json['nome'],
      );

  /// Converts this [BrandEndpoint] to a JSON object.
  Map<String, dynamic> toJson() => {
        'codigo': code,
        'nome': name,
      };

  @override
  String toString() {
    return name!;
  }
}

/// Represents a car model retrieved from the API.
class ModelEndpoint {
  ///
  final int? code;

  ///
  final String? name;

  /// Creates a [BrandEndpoint] from JSON data.
  ModelEndpoint({
    this.code,
    this.name,
  });
////// Parses JSON data to create a [modelEndpoint] instance.
  factory ModelEndpoint.fromJson(Map<String, dynamic> json) => ModelEndpoint(
        code: json['codigo'],
        name: json['nome'],
      );

  /// Converts this [ModelEndpoint] to a JSON object.
  Map<String, dynamic> toJson() => {
        'codigo': code,
        'nome': name,
      };

  @override
  String toString() {
    return name!;
  }
}

/// Fetches a list of car brands from the FIPE API.
Future<List<BrandEndpoint>?> getCarBrands() async {
  const url = 'https://parallelum.com.br/fipe/api/v1/carros/marcas/';
  final uri = Uri.parse(url);

  try {
    final response = await http.get(uri);

    final decodeResult = jsonDecode(response.body);

    final result = <BrandEndpoint>[];

    for (final item in decodeResult) {
      result.add(
        BrandEndpoint.fromJson(item),
      );
    }
    return result;
  } on Exception catch (e) {
    log('$e');
    return null;
  }
}

/// Fetches a list of car models for a specific car brand from the FIPE API.
Future<List<ModelEndpoint>?> getCarModel(String brandName) async {
  final listOfBrands = await getCarBrands();

  var brand = listOfBrands!.firstWhere(
    (element) => element.name == brandName,
    orElse: () => BrandEndpoint(code: null),
  );

  if (brand.code != null) {
    final url =
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/${brand.code}/modelos/';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      final decodeResult = jsonDecode(response.body);
      log(decodeResult['modelos'].toString());

      final result = <ModelEndpoint>[];

      for (final item in decodeResult['modelos']) {
        result.add(
          ModelEndpoint.fromJson(item),
        );
      }
      return result;
    } on Exception catch (e) {
      log('$e');
      return null;
    }
  } else {
    return null;
  }
}
