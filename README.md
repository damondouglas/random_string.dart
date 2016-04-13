# random_string

Simple library for generating random ascii strings.

## Usage

A simple usage example:

    import 'package:random_string/random_string.dart' as random;

    main() {
      print(randomBetween(10,20)); // some integer between 10 and 20
      print(randomNumeric(4)); // sequence of 4 random numbers i.e. 3259
      print(randomString(10)); // random sequence of 10 characters i.e. e~f93(4l-
      print(randomAlpha(5)); // random sequence of 5 alpha characters i.e. aRztC
      print(randomAlphaNumeric(10)); // random sequence of 10 alpha numeric i.e. aRztC1y32B
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/damondouglas/random_string.dart/issues
