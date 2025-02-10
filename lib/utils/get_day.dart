import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String getDayDescription(Timestamp timestamp) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));
  final inputDate = timestamp.toDate();
  final inputDateOnly =
      DateTime(inputDate.year, inputDate.month, inputDate.day);

  if (inputDateOnly == today) {
    return 'Today';
  } else if (inputDateOnly == tomorrow) {
    return 'Tomorrow';
  } else {
    final dateFormat = DateFormat('MMMM d, yyyy');
    return dateFormat.format(inputDate);
  }
}
