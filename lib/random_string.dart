/// Simple library for generating random ascii strings.

library random_string;

import 'dart:math' show Random;

const maxSupportedInteger = 999999999999999;
const minSupportedInteger = 0;
const asciiStart = 33;
const asciiEnd = 126;
const numericStart = 48;
const numericEnd = 57;
const lowerAlphaStart = 97;
const lowerAlphaEnd = 122;
const upperAlphaStart = 65;
const upperAlphaEnd = 90;

final _internal = Random();

/// A generator of double values.
abstract class AbstractRandomProvider {
  /// A non-negative random floating point value is expected
  /// in the range from 0.0, inclusive, to 1.0, exclusive.
  /// A [ProviderError] is thrown if the return value is < 0 or >= 1
  double nextDouble();
}

/// A generator of pseudo-random double values using the default [math.Random].
class DefaultRandomProvider with AbstractRandomProvider {
  const DefaultRandomProvider();

  @override
  double nextDouble() => _internal.nextDouble();
}

/// A generator of random values using a supplied [math.Random].
class CoreRandomProvider with AbstractRandomProvider {
  Random random;

  CoreRandomProvider.from(this.random);

  @override
  double nextDouble() => random.nextDouble();
}

/// Generates a random integer where [from] <= [to] inclusive
/// where 0 <= from <= to <= 999999999999999
int randomBetween(int from, int to,
    {AbstractRandomProvider provider = const DefaultRandomProvider()}) {
  if (from > to) {
    throw ArgumentError('$from cannot be > $to');
  }
  if (from < minSupportedInteger) {
    throw ArgumentError(
        '|$from| is larger than the maximum supported $maxSupportedInteger');
  }

  if (to > maxSupportedInteger) {
    throw ArgumentError(
        '|$to| is larger than the maximum supported $maxSupportedInteger');
  }

  var d = provider.nextDouble();
  if (d < 0 || d >= 1) {
    throw ProviderError(d);
  }
  return _mapValue(d, from, to);
}

int _mapValue(double value, int min, int max) {
  if (min == max) return min;
  var range = (max - min).toDouble();
  return (value * (range + 1)).floor() + min;
}

/// Generates a random string of [length] with characters
/// between ascii [from] to [to].
/// Defaults to characters of ascii '!' to '~'.
String randomString(int length,
    {int from = asciiStart,
    int to = asciiEnd,
    AbstractRandomProvider provider = const DefaultRandomProvider()}) {
  return String.fromCharCodes(List.generate(
      length, (index) => randomBetween(from, to, provider: provider)));
}

/// Generates a random string of [length] with only numeric characters.
String randomNumeric(int length,
        {AbstractRandomProvider provider = const DefaultRandomProvider()}) =>
    randomString(length,
        from: numericStart, to: numericEnd, provider: provider);

/// Generates a random string of [length] with only alpha characters.
String randomAlpha(int length,
    {AbstractRandomProvider provider = const DefaultRandomProvider()}) {
  var lowerAlphaWeight = provider.nextDouble();
  var upperAlphaWeight = provider.nextDouble();
  var sumWeight = lowerAlphaWeight + upperAlphaWeight;
  lowerAlphaWeight /= sumWeight;
  upperAlphaWeight /= sumWeight;
  var lowerAlphaLength = randomBetween(0, length, provider: provider);
  var upperAlphaLength = length - lowerAlphaLength;
  var lowerAlpha = randomString(lowerAlphaLength,
      from: lowerAlphaStart, to: lowerAlphaEnd, provider: provider);
  var upperAlpha = randomString(upperAlphaLength,
      from: upperAlphaStart, to: upperAlphaEnd, provider: provider);
  return randomMerge(lowerAlpha, upperAlpha);
}

/// Generates a random string of [length] with alpha-numeric characters.
String randomAlphaNumeric(int length,
    {AbstractRandomProvider provider = const DefaultRandomProvider()}) {
  var alphaLength = randomBetween(0, length, provider: provider);
  var numericLength = length - alphaLength;
  var alpha = randomAlpha(alphaLength, provider: provider);
  var numeric = randomNumeric(numericLength, provider: provider);
  return randomMerge(alpha, numeric);
}

/// Merge [a] with [b] and shuffle.
String randomMerge(String a, String b) {
  var mergedCodeUnits = List.from('$a$b'.codeUnits);
  mergedCodeUnits.shuffle();
  return String.fromCharCodes(mergedCodeUnits.cast<int>());
}

/// ProviderError thrown when a [Provider] provides a value
/// outside the expected [0, 1) range.
class ProviderError implements Exception {
  final double value;

  ProviderError(this.value);

  @override
  String toString() => 'nextDouble() = $value, only [0, 1) expected';
}
