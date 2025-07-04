import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:machine_test_lilac/features/message_screen/views/message_screen.dart';
import 'package:machine_test_lilac/features/otp_screen/controllers/verify_otp_controller.dart';
import 'package:machine_test_lilac/shared/utils/constants.dart';
import 'package:machine_test_lilac/shared/utils/theme.dart';
import 'package:machine_test_lilac/shared/widgets/common_snackbar.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Controllers for each OTP digit
  final VerifyOtpController otpController = Get.put(VerifyOtpController());

  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field if not the last one
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last field, unfocus
        _focusNodes[index].unfocus();
      }
    }
  }

  void _onKeyPressed(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        // Move to previous field if current is empty
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  String _getOtpCode() {
    return _controllers.map((controller) => controller.text).join();
  }

  bool _isOtpComplete() {
    return _getOtpCode().length == 6;
  }

  void _resendOtp() {
    // Clear all fields
    for (var controller in _controllers) {
      controller.clear();
    }
    // Focus first field
    _focusNodes[0].requestFocus();

    // Show success message (you can replace with actual API call)
    CommonSnackbar.show(context, message: "OTP resent successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Text(
              'Enter your verification\ncode',
              style: AppTheme.titleText(darkTextColor),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Phone number display with edit option
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.phoneNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle edit phone number
                    Get.back();
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 16,
                      color: darkTextColor,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  width: 50,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _controllers[index].text.isNotEmpty
                          ? Colors.blue
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade50,
                  ),
                  child: RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (event) => _onKeyPressed(event, index),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        setState(() {
                          _onDigitChanged(value, index);
                        });
                      },
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // Didn't get anything text and resend option
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Didn't get anything? No worries, let's try again.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: _resendOtp,
                  child: const Text(
                    'Resent',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Verify button
            Obx(() => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(
                    gradient: _isOtpComplete() && !otpController.isLoading.value
                        ? primaryCardColor
                        : LinearGradient(
                            colors: [
                              Colors.grey.shade300,
                              Colors.grey.shade400
                            ],
                          ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    onPressed: _isOtpComplete() &&
                            !otpController.isLoading.value
                        ? () async {
                            // Handle OTP verification
                            String otpCode = _getOtpCode();
                            print('OTP Code: $otpCode');

                            // Show loading indicator
                            CommonSnackbar.show(context,
                                message: "Verifying OTP...");

                            // Call the verification API
                            final success = await otpController.verifyOtp(
                              phone: widget.phoneNumber,
                              otp: otpCode,
                              fcmToken:
                                  "fWPtjnr1SiqgGELTWTuKK3:APA91bFr7V7zNFvrXNWvO07IctjM1Hn1yfvd9YjSBhLvzjEkUTRLEA7iZdqwhulQ4Om-Xaky_CrVfXs-oWMQz1QV8iG-FgbSG2YYtJAWnjNcrX3k0Mv6w_0", // Use your actual FCM token
                            );

                            if (success) {
                              CommonSnackbar.show(context,
                                  message: "OTP Verified Successfully");
                              Get.to(const MessageScreen());
                            } else {
                              // Show error message
                              CommonSnackbar.show(context,
                                  message: otpController.errorMessage.value);
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: lightCardColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                      disabledBackgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.white70,
                    ),
                    child: otpController.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
