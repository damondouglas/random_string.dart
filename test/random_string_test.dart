import 'package:test/test.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' as math;

main() {
  group("randomBetween", () {
    List<int>.generate(2000, (int index) => -1000 + index + 1)
        .forEach((int lower) {
      int upper = lower + math.Random().nextInt(100);
      int value = randomBetween(lower, upper);
      test("$value is within [$lower, $upper]", () {
        expect(value >= lower, true);
        expect(value <= upper, true);
      });
    });
    test('value = lower = upper', () {
      int value = randomBetween(10, 10);
      expect(value, 10);
    });
    test('throws an error if lower > upper', () {
      expect(() => randomBetween(10, -10), throwsException);
    });
  });

  group("randomNumeric", () {
    test("yields an integer only string", () {
      expect(RegExp(r'^\d{10}$').hasMatch(randomNumeric(10)), true);
    });
  });

  group("randomString", () {
    test("yields an ASCII only string", () {
      expect(RegExp(r'^[\x00-\x7F]{100}$').hasMatch(randomString(100)), true);
    });
  });

  group("randomAlpha", () {
    test("yields alpha only string", () {
      expect(RegExp(r'^[a-zA-Z]{100}$').hasMatch(randomAlpha(100)), true);
    });
  });

  group("randomAlphaNumeric", () {
    test("yields an alphanumeric string", () {
      expect(RegExp(r'^[a-zA-Z0-9]{100}$').hasMatch(randomAlphaNumeric(100)),
          true);
    });
  });

  group("Provider", () {
    test("custom with seed yields an expected result", (){
      var r = math.Random(1);
      int value = randomBetween(1, 10, provider: CoreProvider.from(r));
      expect(value, 3);
    });
  });
}

