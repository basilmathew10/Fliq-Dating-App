import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:machine_test_lilac/features/phone_number_screen/views/phone_number_screen.dart';
import 'package:machine_test_lilac/shared/utils/constants.dart';
import 'package:machine_test_lilac/shared/utils/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final maxWidth = isTablet ? 400.0 : screenWidth;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06, // Responsive padding
                ),
                child: Column(
                  children: [
                    const Spacer(flex: 1),

                    // Heart Logo
                    Container(
                      width: screenWidth * 0.12, // Responsive size
                      height: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6446E),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                        child: Image.asset(
                          'assets/images/splash_top_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Main Title & Subtitle
                    ...['Connect. Meet. Love.', 'With Fliq Dating'].map(
                      (text) => Padding(
                        padding: EdgeInsets.only(
                            bottom: text == 'Connect. Meet. Love.' ? 4 : 0),
                        child: Text(
                          text,
                          style: AppTheme.headingText(lightTextColor).copyWith(
                            fontSize: (isTablet ? 30 : 26).sp,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const Spacer(flex: 5),

                    // Sign-in Buttons
                    _buildSignInButton(
                      'Sign in with Google',
                      Colors.white,
                      Colors.black87,
                      'google_logo.png',
                      const Color(0xff2E0E16),
                      screenHeight,
                      () => _handleGoogleSignIn(context),
                    ),
                    const SizedBox(height: 16),

                    _buildSignInButton(
                      'Sign in with Facebook',
                      const Color(0xFF3B5998),
                      lightTextColor,
                      'fb_logo.png',
                      lightTextColor,
                      screenHeight,
                      () => _handleFacebookSignIn(context),
                    ),
                    const SizedBox(height: 16),

                    _buildSignInButton(
                      'Sign in with phone number',
                      buttonColor,
                      lightTextColor,
                      'phone_logo.png',
                      lightTextColor,
                      screenHeight,
                      () => _handlePhoneSignIn(context),
                    ),

                    const SizedBox(height: 8),

                    // Terms and Privacy
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTheme.smallText(Colors.white70),
                        children: [
                          const TextSpan(
                              text: 'By signing up, you agree to our '),
                          _linkSpan('Terms'),
                          const TextSpan(
                              text: '. See how we\nuse your data in our '),
                          _linkSpan('Privacy Policy'),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build individual sign-in button
  Widget _buildSignInButton(
    String text,
    Color bgColor,
    Color fgColor,
    String icon,
    Color textColor,
    double screenHeight,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/$icon', width: 24, height: 24),
            SizedBox(width: text.contains('Facebook') ? 8 : 12),
            Text(text, style: AppTheme.bodyText(textColor)),
          ],
        ),
      ),
    );
  }

  // Handle Google Sign In
  void _handleGoogleSignIn(BuildContext context) {
    // Add your Google sign-in logic here
    Navigator.pushNamed(context, '/google-auth');
    // Or use your preferred navigation method
  }

  // Handle Facebook Sign In
  void _handleFacebookSignIn(BuildContext context) {
    // Add your Facebook sign-in logic here
    Navigator.pushNamed(context, '/facebook-auth');
    // Or use your preferred navigation method
  }

  // Handle Phone Number Sign In
  void _handlePhoneSignIn(BuildContext context) {
    // Add your phone sign-in logic here
    Get.to(const PhoneNumberScreen());
    // Or use your preferred navigation method
  }

  TextSpan _linkSpan(String text) => TextSpan(
        text: text,
        style: AppTheme.mediumTitleText(lightTextColor).copyWith(
          decoration: TextDecoration.underline,
        ),
      );
}

class _ButtonData {
  final String text;
  final Color bgColor;
  final Color fgColor;
  final String icon;
  final Color textColor;
  final VoidCallback onPressed;

  const _ButtonData(this.text, this.bgColor, this.fgColor, this.icon,
      this.textColor, this.onPressed);
}
