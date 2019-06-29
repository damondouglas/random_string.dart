// Copyright (c) 2016, Damon Douglas. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

main() {
  print(randomBetween(10, 20)); // some integer between 10 and 20
  print(randomNumeric(4)); // sequence of 4 random numbers i.e. 3259
  print(randomString(10)); // random sequence of 10 characters i.e. e~f93(4l-
  print(randomAlpha(5)); // random sequence of 5 alpha characters i.e. aRztC
  print(randomAlphaNumeric(10)); // random sequence of 10 alpha numeric i.e. aRztC1y32B

  var r = Random.secure();
  print(randomBetween(10, 20, provider: CoreProvider.from(r))); // You can use a provider from Random.
  print(randomBetween(10, 20, provider: _Provider())); // Or you can implement your own.
}

class _Provider with Provider {
  _Provider();
  double nextDouble() => 0.5;
}
