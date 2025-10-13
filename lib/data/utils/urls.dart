class Urls {
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";

  static const String registrationUrl = "$_baseUrl/Registration";
  static const String loginUrl = "$_baseUrl/Login";
  static const String createTask = "$_baseUrl/createTask";
  static const String statatusCount = "$_baseUrl/taskStatusCount";
  static const String newTaskListUrl = "$_baseUrl/listTaskByStatus/New";
  static const String progressTaskListUrl = "$_baseUrl/listTaskByStatus/Progress";
  static String updateTaskStatus(String id, String newStatus) =>
      "$_baseUrl/updateTaskStatus/$id/$newStatus";
}