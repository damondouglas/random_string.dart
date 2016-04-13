// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:random_string/random_string.dart';
import 'package:test/test.dart';

final TEST_COUNT = 100;
final RANDOM_BETWEEN_FROM = 1;
final RANDOM_BETWEEN_TO = 100;
final STRING_LENGTH = 10;
final ASCII_START = '!'.codeUnitAt(0);
final ASCII_END = '~'.codeUnitAt(0);

final FULL_ASCII =
    new String.fromCharCodes(new List.generate(94, (index) => 33 + index));

final NUMERIC = "0123456789";
final ALPHA = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
final ALPHA_NUMERIC =
    "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

void main() {
  group('random_string', () {
    test('randomBetween', () {
      expect(
          new List.generate(TEST_COUNT,
                  (_) => randomBetween(RANDOM_BETWEEN_FROM, RANDOM_BETWEEN_TO))
              .every((value) => value >= 1 && value <= 100),
          true);
    });

    test('randomBetween(0,0) is always 0', () {
      expect(
          new List.generate(TEST_COUNT, (_) => randomBetween(0, 0))
              .every((value) => value == 0),
          true);
    });

    test('randomString(<length>)', () {
      expect(
          new List.generate(TEST_COUNT, (_) => randomString(STRING_LENGTH))
              .every((String value) {
            return value.codeUnits.every((code) =>
                    FULL_ASCII.contains(new String.fromCharCode(code))) &&
                value.length == STRING_LENGTH;
          }),
          true);
    });

    test('randomString(0) is empty', () {
      expect(randomString(0).isEmpty, true);
    });

    test('randomNumeric', () {
      expect(
          new List.generate(TEST_COUNT, (_) => randomNumeric(STRING_LENGTH))
              .every((String value) {
            return value.codeUnits.every((code) =>
                    NUMERIC.contains(new String.fromCharCode(code))) &&
                value.length == STRING_LENGTH;
          }),
          true);
    });

    test('randomAlpha', () {
      expect(
          new List.generate(TEST_COUNT, (_) => randomAlpha(STRING_LENGTH))
              .every((String value) {
            return value.codeUnits.every(
                    (code) => ALPHA.contains(new String.fromCharCode(code))) &&
                value.length == STRING_LENGTH;
          }),
          true);
    });

    test('randomAlphaNumeric', () {
      expect(
          new List.generate(
                  TEST_COUNT, (_) => randomAlphaNumeric(STRING_LENGTH))
              .every((String value) {
            return value.codeUnits.every((code) =>
                    ALPHA_NUMERIC.contains(new String.fromCharCode(code))) &&
                value.length == STRING_LENGTH;
          }),
          true);
    });
  });
}
