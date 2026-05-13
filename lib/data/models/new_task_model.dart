import 'dart:core';
import 'package:intl/intl.dart';

class NewTaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String email;
  final String createdDate;

  NewTaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.email,
    required this.createdDate,
  });

  factory NewTaskModel.fromJson(Map<String, dynamic> jsonData) {
   // DateTime date = DateTime.parse(jsonData['createdDate']);
    //String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return NewTaskModel(
      id: jsonData['_id'],
      title: jsonData['title'],
      description: jsonData['description'],
      status: jsonData['status'],
      email: jsonData['email'],
      createdDate: DateFormat('dd-MMM-yyyy').format(DateTime.parse(jsonData['createdDate'])),
      //jsonData['createdDate'],
    );
  }
}
