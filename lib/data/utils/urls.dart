class Urls {
  static const String _baseUrl = 'http://192.168.0.196:5000/api/v1';
  static const String registrationUrl = '$_baseUrl/registration';
  static const String loginUrl = '$_baseUrl/login';
  static const String createTaskUrl = '$_baseUrl/createTask';
  static const String newTaskListUrl = '$_baseUrl/listTaskByStatus/New';
  static const String taskStatusCountUrl = '$_baseUrl/taskStatusCount';

  static String changeStatusUrl(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
}
