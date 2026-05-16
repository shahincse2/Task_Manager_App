class Urls {
  static const String _baseUrl = 'http://192.168.0.196:5000/api/v1';

  // Auth Related End Points
  static const String registrationUrl = '$_baseUrl/registration';
  static const String loginUrl = '$_baseUrl/login';
  static const String profileUpdateUrl = '$_baseUrl/profileUpdate';
  static const String resetPasswordUrl = '$_baseUrl/resetPassword';
  static String emailVerifyUrl(String email) => '$_baseUrl/verifyEmail/$email';
  static String verifyOtpUrl(String email, String otp) => '$_baseUrl/verifyOtp/$email/$otp';

  // Task Related End Points
  static const String createTaskUrl = '$_baseUrl/createTask';
  static const String newTaskListUrl = '$_baseUrl/listTaskByStatus/New';
  static const String progressTaskListUrl = '$_baseUrl/listTaskByStatus/Progress';
  static const String cancelledTaskListUrl = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String completedTaskListUrl = '$_baseUrl/listTaskByStatus/Completed';
  static const String taskStatusCountUrl = '$_baseUrl/taskStatusCount';

  static String deleteTaskUrl(String id) => '$_baseUrl/deleteTask/$id';

  static String changeStatusUrl(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
}