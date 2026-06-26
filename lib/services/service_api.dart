import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/service_provider_model.dart';

class ServiceApi {
  // This demo uses a local mock JSON file by default.
  // To use mockapi.io, paste your API URL here.
  static const String serviceUrl = '';

  Future<List<ServiceProviderModel>> fetchServices() async {
    try {
      if (serviceUrl.isNotEmpty) {
        final response = await http.get(Uri.parse(serviceUrl));
        if (response.statusCode == 200) {
          final List data = jsonDecode(response.body) as List;
          return data
              .map((item) => ServiceProviderModel.fromJson(Map<String, dynamic>.from(item)))
              .toList();
        }
      }

      // Fallback mock JSON. This keeps the app working for submission/testing.
      final jsonString = await rootBundle.loadString('assets/data/services.json');
      final List data = jsonDecode(jsonString) as List;
      return data
          .map((item) => ServiceProviderModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      throw Exception('Failed to load services: $e');
    }
  }
}
