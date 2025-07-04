import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:machine_test_lilac/features/otp_screen/services/verify_otp_service.dart';

class VerifyOtpController extends GetxController {
  final OtpService _otpService = OtpService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  
  Future<bool> verifyOtp({
    required String phone,
    required String otp,
    required String fcmToken,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Get device information
      final deviceMeta = await _getDeviceMeta();
      
      // Call API service
      final response = await _otpService.verifyOtp(
        phone: phone,
        otp: otp,
        deviceMeta: deviceMeta,
        fcmToken: fcmToken,
      );
      
      // Check if the response is successful
      if (response['statusCode'] == 200) {
        final data = response['data'];
        final rawResponse = response['rawResponse'];

        if (data != null && rawResponse != null && rawResponse['data'] != null) {
          String? accessToken;
          
          try {
            if (data is Map<String, dynamic> && data['auth_status'] != null) {
              accessToken = data['auth_status']['access_token'];
            }
            
            if (accessToken == null && 
                rawResponse['data'] != null && 
                rawResponse['data']['attributes'] != null &&
                rawResponse['data']['attributes']['auth_status'] != null) {
              accessToken = rawResponse['data']['attributes']['auth_status']['access_token'];
              print('Found access_token in raw response attributes: $accessToken');
            }
            
            if (accessToken == null && 
                rawResponse['data'] != null && 
                rawResponse['data']['auth_status'] != null) {
              accessToken = rawResponse['data']['auth_status']['access_token'];
            }
            
          } catch (e) {
            print('Error extracting access_token: $e');
          }
          
          // Only proceed if access_token exists
          if (accessToken != null && accessToken.isNotEmpty) {
            // Store access token in secure storage
            await _secureStorage.write(key: 'access_token', value: accessToken);
            
            isLoading.value = false;
            return true;
          } else {
            // Access token not found in response
            errorMessage.value = 'Authentication failed. Please try again.';
            isLoading.value = false;
            return false;
          }
        } else {
          // API returned 200 but without data (likely only status and message)
          // This means verification failed but API responded successfully
          String? serverMessage;
          
          // Check for message in the response
          if (rawResponse != null) {
            serverMessage = rawResponse['message'];
          }
          
          if (serverMessage != null) {
            errorMessage.value = 'Make sure the number is correct';
          } else {
            errorMessage.value = 'Verification failed. Please try again.';
          }
          
          isLoading.value = false;
          return false;
        }
      } else {
        // API returned error or non-200 status
        if (response['message'] != null) {
          errorMessage.value = response['message'];
        } else {
          errorMessage.value = 'Verification failed. Please try again.';
        }
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      print('Error in verifyOtp: $e');
      errorMessage.value = 'An error occurred. Please try again.';
      isLoading.value = false;
      return false;
    }
  }
  
  Future<Map<String, dynamic>> _getDeviceMeta() async {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return {
          "type": "Android",
          "device-name": androidInfo.model ?? "",
          "device-os-version": androidInfo.version.release ?? "",
          "browser": null,
          "browser_version": null,
          "user-agent": null,
          "screen_resolution": null,
          "language": null,
        };
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return {
          "type": "iOS",
          "device-name": iosInfo.model ?? "",
          "device-os-version": iosInfo.systemVersion ?? "",
          "browser": null,
          "browser_version": null,
          "user-agent": null,
          "screen_resolution": null,
          "language": null,
        };
      } else {
        // Fallback for other platforms
        return {
          "type": "Unknown",
          "device-name": "",
          "device-os-version": "",
          "browser": null,
          "browser_version": null,
          "user-agent": null,
          "screen_resolution": null,
          "language": null,
        };
      }
    } catch (e) {
      print('Error getting device info: $e');
      // Return default values if device info fails
      return {
        "type": "Unknown",
        "device-name": "",
        "device-os-version": "",
        "browser": null,
        "browser_version": null,
        "user-agent": null,
        "screen_resolution": null,
        "language": null,
      };
    }
  }
  
  // Method to get stored access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }
  
  // Method to clear stored data (for logout)
  Future<void> clearStoredData() async {
    await _secureStorage.deleteAll();
  }
}
