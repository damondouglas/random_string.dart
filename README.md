# random_string

Simple library for generating random ascii strings.  

## Design goals and limitations

While this package provides `randomBetween` for convenience, as the name implies, the design goal of this package 
is for random generation of ascii strings, particularly for testing and not for cryptographic purposes.  
With that stated, consider an alternative means of random number generation if your needs fall outside these goals
and limitations. 

## Usage

A simple usage example:
```dart
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

main() {
  print(randomBetween(10, 20)); // some integer between 10 and 20 where 0 <= min <= max <= 999999999999999
  print(randomNumeric(4)); // sequence of 4 random numbers i.e. 3259
  print(randomString(10)); // random sequence of 10 characters i.e. e~f93(4l-
  print(randomAlpha(5)); // random sequence of 5 alpha characters i.e. aRztC
  print(randomAlphaNumeric(10)); // random sequence of 10 alpha numeric i.e. aRztC1y32B

  var r = Random.secure();
  print(randomBetween(10, 20, provider: CoreRandomProvider.from(r))); // You can use a provider from Random.
  print(randomBetween(10, 20, provider: _Provider())); // Or you can implement your own.
}

class _Provider with AbstractRandomProvider {
  _Provider();
  double nextDouble() => 0.5;
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/damondouglas/random_string.dart/issues
