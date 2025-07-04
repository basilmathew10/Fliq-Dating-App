class ApiList {
  static const String baseUrl = "https://test.myfliqapp.com/api/v1";

  static String sentOTP = "$baseUrl/auth/registration-otp-codes/actions/phone/send-otp";
  static String verifyOTP = "$baseUrl/auth/registration-otp-codes/actions/phone/verify-otp";
  static String contactUsers = "$baseUrl/chat/chat-messages/queries/contact-users";
  static String chat = "$baseUrl/chat/chat-messages/queries/chat-between-users/81/99";

}