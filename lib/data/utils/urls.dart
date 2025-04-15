class Urls {
  static const _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const registerUrl = '$_baseUrl/Registration';
  static const loginUrl = '$_baseUrl/Login';
  static const updateProfileUrl = '$_baseUrl/ProfileUpdate';
  static recoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static const recoverResetPassword = '$_baseUrl/RecoverResetPassword';

  static const createTaskUrl = '$_baseUrl/createTask';
  static const taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static const newTaskListUrl = '$_baseUrl/listTaskByStatus/New';
  static const progressTaskListUrl = '$_baseUrl/listTaskByStatus/Progress';
  static recoverVerifyEmailUrl(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static recoverVerifyOtpUrl(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOtp/$email/$otp';
  static const recoverResetPasswordUrl = '$_baseUrl/RecoverResetPassword';
  static deleteTaskUrl(String id) => '$_baseUrl/deleteTask/$id';
  static updateTaskStatusUrl(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
  static const completedTaskListUrl = '$_baseUrl/listTaskByStatus/completed';
  static const canceledTaskListUrl = '$_baseUrl/listTaskByStatus/Canceled';
}
