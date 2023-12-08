import 'package:flutter_test/flutter_test.dart';
import 'package:locator/app/utils/Utils.dart';

void main() {
  test('epochMillisecondsToTime should format epoch milliseconds to time', () {
    const epochMilliseconds = 1638792000000;

    final result = epochMillisecondsToTime(epochMilliseconds);

    expect(result, matches(r'\d{2}:\d{2}'));
  });

  test('minutesDifference should calculate the difference in minutes', () {
    const epochMilliseconds = 1638792000000;

    final result = minutesDifference(epochMilliseconds);

    expect(result, isNonNegative);
  });
}
