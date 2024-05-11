class ApiUrls {
  //static const String baseUrl = 'http://localhost:3000';
  static const String baseUrl = 'https://techproguide.store';
  static const String checkEmailExistsUrl = '$baseUrl/checkEmailExists';
  static const String sendEmailVerificationCodeUrl =
      '$baseUrl/sendEmailVerificationCode';
  static const String verifyEmailUrl = '$baseUrl/verifyEmail';
  static const String userRegisterUrl = '$baseUrl/userregister';
  static const String userLoginUrl = '$baseUrl/userlogin';
  static const String licenseStatusUrl = '$baseUrl/licenseStatus';
  static const String purchaseLicenseUrl = '$baseUrl/purchaseLicense';
  static const String renewLicenseUrl = '$baseUrl/renewLicense';
  static const String userInfoUrl = '$baseUrl/user';
  static const String licenseInfoUrl = '$baseUrl/licenseInfo';
  static const String avatarUrl = '$baseUrl/getAvatar';
  static const String uploadAvatarUrl = '$baseUrl/uploadAvatar';
  static const String checkUidAndLicense = '$baseUrl/check-uid-license';
}
