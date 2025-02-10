import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String? id;
  final String? categoryId;
  final String? task;
  final Timestamp? date;
  final bool? isComplete;

  TaskModel({
    this.id,
    this.categoryId,
    this.task,
    this.date,
    this.isComplete,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'task': task,
      'date': date,
      'isComplete': isComplete,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      categoryId: json['categoryId'],
      isComplete: json['isComplete'],
      task: json['task'],
      date: json['date'] != null ? json['date'] as Timestamp : null,
    );
  }

  /// **Helper Method to Format Date**
  String getFormattedDate() {
    if (date == null) return "";

    DateTime taskDate = date!.toDate();
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    if (_isSameDay(taskDate, today)) {
      return "Today";
    } else if (_isSameDay(taskDate, tomorrow)) {
      return "Tomorrow";
    } else {
      return "${taskDate.day}-${taskDate.month}-${taskDate.year}";
    }
  }

  /// **Check if two dates are the same day**
  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
