class ApiUrl {
//============= Base URL ===============\\
  static const baseUrl = "https://api.essemobility.com/api";

//============ Auth Section =============\\
  static const login = "/riders/login";
  static const initiate = "/riders/initiate";
  static const completeRegistration = "/riders/complete-registration";
  static const verifyOtp = "/riders/verify-otp";
  static const resendOtp = "/riders/resend-otp";
  static const logout = "/riders/logout";

  //============= Rider ================\\
  static const getRiderProfile = "/riders/user";
  static const editProfile = "/riders/user";

  //=============== Booking ====================\\
  static const rideAmount = "/ride-amount";
}
