import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test_lilac/shared/utils/api_list.dart';
import '../models/contact_user_model.dart';

class ContactUserService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  /// Fetches contact users from the API
  static Future<ContactUserModel?> getContactUsers() async {
    try {
      // Get access token from secure storage
      final accessToken = await _secureStorage.read(key: 'access_token');
      
      if (accessToken == null) {
        print('Access token not found');
        return null;
      }


      // Make API request
      final response = await http.get(
        Uri.parse(ApiList.contactUsers),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('API Response: $jsonData'); // Add this for debugging
        return ContactUserModel.fromJson(jsonData);
      } else {
        print('API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching contact users: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}