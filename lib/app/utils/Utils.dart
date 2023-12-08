

String epochMillisecondsToTime(int epochMilliseconds) {
  var dateTime =
      DateTime.fromMillisecondsSinceEpoch(epochMilliseconds, isUtc: true);
  dateTime = dateTime.toLocal();

  final formattedTime =
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

  return formattedTime;
}

int minutesDifference(int epochMilliseconds) {
  var dateTime = DateTime.fromMillisecondsSinceEpoch(epochMilliseconds, isUtc: true);
  dateTime = dateTime.toLocal();

  final now = DateTime.now();
  final difference = now.difference(dateTime);
  return difference.inMinutes;
}



