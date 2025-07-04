import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test_lilac/features/otp_screen/views/otp_screen.dart';
import 'package:machine_test_lilac/features/phone_number_screen/controllers/send_otp_controllers.dart';
import 'package:machine_test_lilac/shared/utils/constants.dart';
import 'package:machine_test_lilac/shared/utils/theme.dart';
import 'package:machine_test_lilac/shared/widgets/common_snackbar.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final OtpController otpController = Get.put(OtpController());

  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+91';
  String? _phoneError;

  // Country codes list
  final List<CountryCode> _countryCodes = [
    CountryCode(code: '+91', name: 'India', flag: '🇮🇳'),
    CountryCode(code: '+1', name: 'United States', flag: '🇺🇸'),
    CountryCode(code: '+44', name: 'United Kingdom', flag: '🇬🇧'),
    CountryCode(code: '+86', name: 'China', flag: '🇨🇳'),
    CountryCode(code: '+81', name: 'Japan', flag: '🇯🇵'),
    CountryCode(code: '+49', name: 'Germany', flag: '🇩🇪'),
    CountryCode(code: '+33', name: 'France', flag: '🇫🇷'),
    CountryCode(code: '+39', name: 'Italy', flag: '🇮🇹'),
    CountryCode(code: '+34', name: 'Spain', flag: '🇪🇸'),
    CountryCode(code: '+61', name: 'Australia', flag: '🇦🇺'),
    CountryCode(code: '+55', name: 'Brazil', flag: '🇧🇷'),
    CountryCode(code: '+7', name: 'Russia', flag: '🇷🇺'),
    CountryCode(code: '+82', name: 'South Korea', flag: '🇰🇷'),
    CountryCode(code: '+65', name: 'Singapore', flag: '🇸🇬'),
    CountryCode(code: '+971', name: 'UAE', flag: '🇦🇪'),
    CountryCode(code: '+966', name: 'Saudi Arabia', flag: '🇸🇦'),
    CountryCode(code: '+60', name: 'Malaysia', flag: '🇲🇾'),
    CountryCode(code: '+66', name: 'Thailand', flag: '🇹🇭'),
    CountryCode(code: '+84', name: 'Vietnam', flag: '🇻🇳'),
    CountryCode(code: '+62', name: 'Indonesia', flag: '🇮🇩'),
  ];

  void _validatePhoneNumber(String value) {
    setState(() {
      if (value.isEmpty) {
        _phoneError = 'Phone number is required';
      } else if (value.length < 10) {
        _phoneError = 'Phone number must be 10 digits';
      } else if (value.length > 10) {
        _phoneError = 'Phone number cannot exceed 10 digits';
      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        _phoneError = 'Phone number must contain only digits';
      } else {
        _phoneError = null;
      }
    });
  }

  void _showCountryCodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Country Code',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: ListView.builder(
              itemCount: _countryCodes.length,
              itemBuilder: (context, index) {
                final country = _countryCodes[index];
                return ListTile(
                  leading: Text(
                    country.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(
                    '${country.name} (${country.code})',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedCountryCode = country.code;
                    });
                    Get.back();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: greyTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
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
              'Enter your phone\nnumber',
              style: AppTheme.titleText(darkTextColor),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _phoneError != null ? Colors.red : Colors.grey[350]!,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Country code dropdown
                  GestureDetector(
                    onTap: _showCountryCodeDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.phone_android,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _selectedCountryCode,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: darkTextColor,
                                fontSize: 16),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Divider
                  Container(
                    height: 24,
                    width: 1,
                    color: Colors.grey[300],
                  ),

                  // Phone number field
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: darkTextColor,
                          fontSize: 16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone number',
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: greyTextColor),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        counterText: '', // Hide character counter
                        errorText: null, // We'll show error below
                      ),
                      onChanged: (value) {
                        _validatePhoneNumber(value);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Error message
            if (_phoneError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16),
                child: Text(
                  _phoneError!,
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

            const SizedBox(height: 8),

            // Helper text
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Fliq will send you a text with a verification code.',
                  style: AppTheme.smallText(greyTextColor),
                ),
              ],
            ),

            const Spacer(),

            // Next button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                gradient: primaryCardColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  // Check if already loading
                  if (otpController.isLoading.value) return;

                  // Validate phone number first
                  if (_phoneController.text.isEmpty) {
                    CommonSnackbar.show(context,
                        message: "Please enter a phone number");
                    return;
                  }

                  // Create full phone number
                  final fullPhoneNumber =
                      "$_selectedCountryCode${_phoneController.text}";

                  // Call API to send OTP
                  final success =
                      await otpController.sendOtp(fullPhoneNumber, context);

                  // Navigate to OTP screen if successful
                  if (success) {
                    if (mounted) {
                      Get.to(OtpScreen(
                        phoneNumber:
                            "$_selectedCountryCode ${_phoneController.text}",
                      ));
                    }
                  } else {
                    print('Navigation skipped - API call failed');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: lightCardColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Obx(
                  () => otpController.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Country code model
class CountryCode {
  final String code;
  final String name;
  final String flag;

  CountryCode({
    required this.code,
    required this.name,
    required this.flag,
  });
}
