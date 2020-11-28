import 'dart:math';

import 'package:test/test.dart';
import 'package:random_string/random_string.dart';

const max = 999999999999999;
const mid = 500000000000000;
const precision = 15;

class TestProvider with AbstractRandomProvider {
  final double value;
  TestProvider(this.value);
  @override
  double nextDouble() => this.value;
}

class TestCase {
  double value;
  int from;
  int to;
  int want;
  bool wantArgumentError;
  TestCase({
    this.value = 0.0,
    this.from = 0,
    this.to = 0,
    this.want = 0,
    this.wantArgumentError = false,
  });
}

main() {
  group("_mapValue", () {
    var cases = [
      TestCase(
        from: 1,
        wantArgumentError: true,
      ),
      TestCase(
        to: max + 1,
        wantArgumentError: true,
      ),
      TestCase(
        from: -1,
        wantArgumentError: true,
      ),
      TestCase(),
      TestCase(
        to: mid,
      ),
      TestCase(
        to: max,
      ),
      TestCase(
        from: mid,
        to: max,
        want: mid,
      ),
      TestCase(
        from: max,
        to: max,
        want: max,
      ),
      TestCase(
        to: mid,
        value: mid / pow(10, precision),
        want: (mid / 2).round(),
      ),
      TestCase(
        to: max,
        value: mid / pow(10, precision),
        want: (max / 2).round(),
      ),
      TestCase(
        from: mid,
        to: max,
        value: mid / pow(10, precision),
        want: mid + ((max - mid) / 2).round(),
      ),
      TestCase(
        to: max,
        value: max / pow(10, precision),
        want: max,
      ),
    ];
    test('min <= _mapValue() <= max', () {
      cases.forEach((TestCase testCase) {
        var value = testCase.value;
        var from = testCase.from;
        var to = testCase.to;
        var want = testCase.want;

        var p = TestProvider(value);

        if (testCase.wantArgumentError) {
          expect(
              () => randomBetween(from, to, provider: p), throwsArgumentError);
          return;
        }

        var got = randomBetween(from, to, provider: p);
        expect(got, want, reason: "want: $from <= $want <= $to , got: $got");
      });
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
}
