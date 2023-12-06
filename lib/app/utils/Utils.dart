import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

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

  // The difference is returned in minutes
  return difference.inMinutes;
}



Future<Uint8List?> getImageBytes(String imageUrl) async {
  try {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      log('Error loading image:');

      return null;
    }
  } catch (e) {
    log('Error loading image: $e');
    return null;
  }
}



