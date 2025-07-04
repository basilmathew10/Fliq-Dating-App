import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:machine_test_lilac/shared/utils/api_list.dart';

class OtpService {
  
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
    required Map<String, dynamic> deviceMeta,
    required String fcmToken,
  }) async {
    try {
      final url = Uri.parse(ApiList.verifyOTP);
      
      // Prepare request body in JSON:API format
      final requestBody = {
        "data": {
          "type": "registration-otp-codes",
          "attributes": {
            "phone": phone,
            "otp": int.tryParse(otp) ?? 0,
            "device_meta": deviceMeta,
            "fcm_token": fcmToken,
          }
        }
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse JSON:API response using japx
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        
        // Use japx to decode JSON:API format
        final decodedResponse = Japx.decode(jsonResponse);
        
        return {
          'success': true,
          'statusCode': response.statusCode,
          'data': decodedResponse,
          'rawResponse': jsonResponse,
        };
      } else {
        // Handle error responses
        final errorResponse = jsonDecode(response.body);
        return {
          'success': false,
          'statusCode': response.statusCode,
          'message': errorResponse['message'] ?? 'Verification failed',
          'data': errorResponse,
        };
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      return {
        'success': false,
        'statusCode': 0,
        'message': 'Network error occurred',
        'error': e.toString(),
      };
    }
  }
}