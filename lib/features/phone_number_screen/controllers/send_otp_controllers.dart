import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_lilac/features/phone_number_screen/services/send_otp_services.dart';
import 'package:machine_test_lilac/shared/widgets/common_snackbar.dart';

class OtpController extends GetxController {
  final OtpService _otpService = OtpService();

  // Observable variables
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Method to send OTP
  Future<bool> sendOtp(String phoneNumber, BuildContext context) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print('Sending OTP to: $phoneNumber'); // Debug print

      final result = await _otpService.sendOtp(phoneNumber);

      print('Service result: $result'); // Debug print

      if (result['success']) {
        // Show success message
        CommonSnackbar.show(context, message: result['message']);
        return true;
      } else {
        // Show error message
        errorMessage.value = result['message'];
        CommonSnackbar.show(context, message: result['message']);
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
      CommonSnackbar.show(context, message: "An unexpected error occurred: $e");

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }
}
