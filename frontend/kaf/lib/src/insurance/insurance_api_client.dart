import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'customer.dart';

/// Exception thrown when locationSearch fails.
class CustomerRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class CustomerNotFound implements Exception {}

class CustomerSerializationFailure implements Exception {}

class UploadFileFailure implements Exception {}

class CustomerApiClient {
  CustomerApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  // static const _baseUrl = 'api.open-meteo.com';
  static const _baseUrl = 'localhost:8000';

  final http.Client _httpClient;
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000'));

  /// Finds a [customer] `/customer/?name=(query)`.
  Future<List<Customer>> customerSearch(String? query) async {
    final req = Uri.http(
      _baseUrl,
      '/customers',
      {'name': query},
    );

    final response = await _httpClient.get(req);

    if (response.statusCode != 200) {
      throw CustomerRequestFailure();
    }

    final customerJson = jsonDecode(response.body) as Map;

    if (!customerJson.containsKey('results')) throw CustomerNotFound();

    final results = customerJson['results'] as List;

    if (results.isEmpty) throw CustomerNotFound();

    try {
      return List.from(
        results.map((v) => Customer.fromJson(v)),
      );
    } on Exception {
      throw CustomerSerializationFailure();
    }
  }

  Future<void> uploadExcelFile(File file) async {
    final formData = FormData.fromMap({
      'File': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    });
    final response = await dio.post('/import-customer-data/', data: formData);

    if (response.statusCode != 200) {
      throw CustomerRequestFailure();
    }
  }
}
