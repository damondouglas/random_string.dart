// Copyright (c) 2016, Damon Douglas. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

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

abstract class Provider {
  double nextDouble();
}

class DefaultProvider with Provider {
  const DefaultProvider();
  double nextDouble() => _internal.nextDouble();
}

class CoreProvider with Provider {
  Random random;
  CoreProvider.from(this.random);
  double nextDouble() => random.nextDouble();
}

/// Generates a random integer where [from] <= [to].
int randomBetween(int from, int to, {Provider provider = const DefaultProvider()}) {
  if (from > to) throw new Exception('$from cannot be > $to');
  double randomDouble = provider.nextDouble();
  if (randomDouble < 0) randomDouble *= -1;
  if (randomDouble > 1) randomDouble = 1/randomDouble;
  return ((to - from) * provider.nextDouble()).toInt() + from;
}

/// Generates a random string of [length] with characters
/// between ascii [from] to [to].
/// Defaults to characters of ascii '!' to '~'.
String randomString(int length, {int from = ASCII_START, int to = ASCII_END, Provider provider = const DefaultProvider()}) {
  return new String.fromCharCodes(
      new List.generate(length, (index) => randomBetween(from, to, provider: provider)));
}

/// Generates a random string of [length] with only numeric characters.
String randomNumeric(int length, {Provider provider = const DefaultProvider()}) =>
    randomString(length, from: NUMERIC_START, to: NUMERIC_END, provider: provider);

/// Generates a random string of [length] with only alpha characters.
String randomAlpha(int length, {Provider provider = const DefaultProvider()}) {
  var lowerAlphaLength = randomBetween(0, length, provider: provider);
  var upperAlphaLength = length - lowerAlphaLength;
  var lowerAlpha = randomString(lowerAlphaLength,
      from: LOWER_ALPHA_START, to: LOWER_ALPHA_END, provider: provider);
  var upperAlpha = randomString(upperAlphaLength,
      from: UPPER_ALPHA_START, to: UPPER_ALPHA_END, provider: provider);
  return randomMerge(lowerAlpha, upperAlpha);
}

/// Generates a random string of [length] with alpha-numeric characters.
String randomAlphaNumeric(int length, {Provider provider = const DefaultProvider()}) {
  var alphaLength = randomBetween(0, length, provider: provider);
  var numericLength = length - alphaLength;
  var alpha = randomAlpha(alphaLength, provider: provider);
  var numeric = randomNumeric(numericLength, provider: provider);
  return randomMerge(alpha, numeric);
}

/// Merge [a] with [b] and shuffle.
String randomMerge(String a, String b) {
  List<int> mergedCodeUnits = new List.from("$a$b".codeUnits);
  mergedCodeUnits.shuffle();
  return new String.fromCharCodes(mergedCodeUnits);
}
