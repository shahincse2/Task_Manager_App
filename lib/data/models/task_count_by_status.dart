class TaskCountByStatus {
  final String id;
  final int sum;

  TaskCountByStatus({required this.id, required this.sum});

  factory TaskCountByStatus.fromJson(Map<String, dynamic> jsonData) {
    return TaskCountByStatus(id: jsonData['_id'], sum: jsonData['sum']);
  }
}
