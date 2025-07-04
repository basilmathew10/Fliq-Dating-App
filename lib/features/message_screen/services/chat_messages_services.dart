import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:machine_test_lilac/shared/utils/api_list.dart';
import '../models/chat_messages_model.dart';

class ChatMessagesService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<ChatMessagesModel?> getChatMessages() async {
    try {
      // Get access token from secure storage
      final accessToken = await _secureStorage.read(key: 'access_token');

      if (accessToken == null) {
        print('Access token not found');
        return null;
      }

      // Prepare the API endpoint
      final url = Uri.parse(ApiList.chat);

      // Make the API call
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print("StatusCode${response.statusCode}");

      if (response.statusCode == 200) {
        print("ResponseBody${response.body}");
        // Parse JSON:API response using japx
        final jsonData = json.decode(response.body);
        final normalizedData = Japx.decode(jsonData);

        // Convert to ChatMessagesModel
        final chatMessages = ChatMessagesModel.fromJson(normalizedData);
        return chatMessages;
      } else {
        print('Failed to fetch chat messages: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching chat messages: $e');
      return null;
    }
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }
}
