import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:japx/japx.dart';
import 'package:machine_test_lilac/shared/utils/api_list.dart';

class OtpService {
  
  Future<Map<String, dynamic>> sendOtp(String phoneNumber) async {
    try {
      final url = Uri.parse(ApiList.sentOTP);
      
      final body = {
        "data": {
          "type": "registration_otp_codes",
          "attributes": {
            "phone": phoneNumber
          }
        }
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {        
        try {
          // Parse JSON:API response using japx
          final jsonApiResponse = json.decode(response.body);
          
          final parsedResponse = Japx.decode(jsonApiResponse);
          
          return {
            'success': true,
            'data': parsedResponse,
            'message': 'OTP sent successfully'
          };
        } catch (parseError) {
          print('Parse error: $parseError');
          return {
            'success': true,
            'data': json.decode(response.body),
            'message': 'OTP sent successfully'
          };
        }
      } else {
        // Handle error response
        final errorResponse = json.decode(response.body);
        return {
          'success': false,
          'error': errorResponse,
          'message': 'Failed to send OTP'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
        'message': 'Network error occurred'
      };
    }
  }
}
