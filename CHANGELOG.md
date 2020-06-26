# Changelog

## 2.1.0
- Fix error with randomBetween previously [min, max) to [min, max]
- Added `ProviderError` to throw errors when `Provider.nextDouble()` is outside [0, 1)
- Added randomBetween(min, max) range limitation 0 <= min <= max <= 999999999999999

## 2.0.1
- Fix warnings per [pana](https://pub.dev/packages/pana) v0.13.2

## 2.0.0
- Renamed `Provider` to `AbstractRandomProvider`
- Renamed `CoreProvider` to `CoreRandomProvider`
- Renamed `DefaultProvider` to `DefaultRandomProvider`

## 1.1.0

- Enabled a custom provider with Random from 'dart:math' serving as default.

## 1.0.0

- Added tests
- Changed sdk environment to '>=2.1.0 <3.0.0'

## 0.0.2

- Added Support for Dart 2
- Fixed Error: The argument type 'dart.core::List<dynamic>'

## 0.0.1

- Initial version, created by Stagehand
- Added randomBetween, randomString, randomNumeric, randomAlpha, randomAlphaNumeric, and randomMerge.

