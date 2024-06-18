import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return 'Только что';
  } else if (difference.inMinutes < 5) {
    String minuteWord;
    switch (difference.inMinutes) {
      case 1:
        minuteWord = 'минуту';
        break;
      case 2:
      case 3:
      case 4:
        minuteWord = 'минуты';
        break;
      default:
        minuteWord = 'минут';
    }
    return '${difference.inMinutes} $minuteWord назад';
  } else if (now.year == dateTime.year && now.month == dateTime.month && now.day == dateTime.day) {
    return DateFormat('HH:mm').format(dateTime);
  } else if (now.year == dateTime.year && now.month == dateTime.month && now.day == dateTime.day + 1) {
    return 'Вчера';
  } else {
    return DateFormat('dd.MM.yy').format(dateTime);
  }
}

String formatSeparatorDate(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays == 0) {
    return "Сегодня";
  } else if (difference.inDays == 1) {
    return "Вчера";
  } else {
    return "${date.day}/${date.month}/${date.year}";
  }
}
