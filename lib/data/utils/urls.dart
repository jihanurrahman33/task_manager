class Urls {
  static const _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const registerUrl = '$_baseUrl/Registration';
  static const loginUrl = '$_baseUrl/Login';
  static const updateProfileUrl = '$_baseUrl/ProfileUpdate';
  static recoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static recoverVerifyOtp(String otpCode) =>
      '$_baseUrl/RecoverVerifyOtp/$otpCode';
  static const recoverResetPassword = '$_baseUrl/RecoverResetPassword';

  static const createTaskUrl = '$_baseUrl/createTask';
  static const taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static const newTaskListUrl = '$_baseUrl/listTaskByStatus/New';
}
