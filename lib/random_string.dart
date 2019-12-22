/// Simple library for generating random ascii strings.

library random_string;

import 'dart:math' show Random;

const ASCII_START = 33;
const ASCII_END = 126;
const NUMERIC_START = 48;
const NUMERIC_END = 57;
const LOWER_ALPHA_START = 97;
const LOWER_ALPHA_END = 122;
const UPPER_ALPHA_START = 65;
const UPPER_ALPHA_END = 90;

final _internal = Random();

abstract class AbstractRandomProvider {
  double nextDouble();
}

class DefaultRandomProvider with AbstractRandomProvider {
  const DefaultRandomProvider();

  @override
  double nextDouble() => _internal.nextDouble();
}

class CoreRandomProvider with AbstractRandomProvider {
  Random random;

  CoreRandomProvider.from(this.random);

  @override
  double nextDouble() => random.nextDouble();
}

/// Generates a random integer where [from] <= [to].
int randomBetween(int from, int to,
    {AbstractRandomProvider provider = const DefaultRandomProvider()}) {
  if (from > to) throw Exception('$from cannot be > $to');
  var randomDouble = provider.nextDouble();
  if (randomDouble < 0) randomDouble *= -1;
  if (randomDouble > 1) randomDouble = 1 / randomDouble;
  return ((to - from) * provider.nextDouble()).toInt() + from;
}

/// Generates a random string of [length] with characters
/// between ascii [from] to [to].
/// Defaults to characters of ascii '!' to '~'.
String randomString(int length,
    {int from = ASCII_START,
    int to = ASCII_END,
    AbstractRandomProvider provider = const DefaultRandomProvider()}) {
  return String.fromCharCodes(List.generate(
      length, (index) => randomBetween(from, to, provider: provider)));
}

/// Generates a random string of [length] with only numeric characters.
String randomNumeric(int length,
        {AbstractRandomProvider provider = const DefaultRandomProvider()}) =>
    randomString(length,
        from: NUMERIC_START, to: NUMERIC_END, provider: provider);

/// Generates a random string of [length] with only alpha characters.
String randomAlpha(int length,
    {AbstractRandomProvider provider = const DefaultRandomProvider()}) {
  var lowerAlphaLength = randomBetween(0, length, provider: provider);
  var upperAlphaLength = length - lowerAlphaLength;
  var lowerAlpha = randomString(lowerAlphaLength,
      from: LOWER_ALPHA_START, to: LOWER_ALPHA_END, provider: provider);
  var upperAlpha = randomString(upperAlphaLength,
      from: UPPER_ALPHA_START, to: UPPER_ALPHA_END, provider: provider);
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
