# profanity_filter

![Dart CI](https://github.com/roshanrahman/profanity_filter/workflows/Dart%20CI/badge.svg)

![Pub Version](https://img.shields.io/pub/v/profanity_filter)

Simple Dart class to create filters with methods to check and censor strings against profanity. A default English words list is provided (from [LDNOOBW on GitHub](
  //https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words)).

You can also use the filters to filter out a custom set of words, by using the `ProfanityFilter.filterOnly()` constructor.

## Usage

To use this plugin, add `profanity_filter` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

> Note:
> The current version `1.0.4` has some refactoring changes (see [CHANGELOG](CHANGELOG.md)), such as methods marked deprecated that should still work. However, if you are facing any issues, use the version `1.0.2` instead, and post an issue in the GitHub repository.

### Example

```dart
import 'package:profanity_filter/profanity_filter.dart';

void main() {
  //Create the filter with the default constructor.
  //The default constructor uses the default list of words provided by [LDNOOBW on GitHub](
  //https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words)
  //Other constructors are available, see [README.md](https://pub.dev/packages/profanity_filter).
  final filter = ProfanityFilter();

  //This string contains the profanity 'ass'
  String badString = 'You are an ass';

  //Check for profanity - returns a boolean (true if profanity is present)
  bool hasProfanity = filter.hasProfanity(badString);
  print('The string $badString has profanity: $hasProfanity');

  //Get the profanity used - returns a List<String>
  List<String> wordsFound = filter.getAllProfanity(badString);
  print('The string contains the words: $wordsFound');

  //Censor the string - returns a 'cleaned' string.
  String cleanString = filter.censor(badString);
  print('Censored version of "$badString" is "$cleanString"');
}
```

## Methods

### `hasProfanity` - Detect if a string contains profanity

Use the `hasProfanity()` method of the filter instance. Pass in the string to be tested.

#### Example

```dart
final filter = ProfanityFilter();
String badString = 'you are an ass';
filter.hasProfanity(badString); //Returns true.
```
### `getAllProfanity` - Get a list of all profane words found

Use the `getAllProfanity()` method of the filter instance. Pass in the string to be tested.

#### Example

```dart

final filter = ProfanityFilter();
String badString = 'you are an ass';
List<String> wordsFound = filter.getAllProfanity(badString); //Returns ['ass']
```

Optionally, you can provide your own clean replacement word to the `replaceWith` named parameter.
`filter.censor(string, replaceWith:'[censored]')` will replace any profanity in `string` with `[censored]`

### `censor` - Censor a string (replace profanity with something clean)

Use the `censor()` method of the filter instance. Pass in the string to be censored.

#### Example

```dart
final filter = ProfanityFilter();
String badString = 'you are an ass';
String cleanString = filter.censor('you are an ass'); //cleanString: 'you are an ***'
```

Optionally, you can provide your own clean replacement word to the `replaceWith` named parameter.
`filter.censor(string, replaceWith:'[censored]')` will replace any profanity in `string` with `[censored]`

## Default Profanity List

The default profanity list is taken from the [LDNOOBW list](https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words), licensed under a Creative Commons Attribution 4.0 International License.

To create a filter with the default list, use the default constructor `ProfanityFilter()`

### Variations

#### To include custom words alongside default list

Use `ProfanityFilter.filterAdditionally()` constructor and pass your list of custom words.

This will use a list which is equivalent to `Default List + Custom List`

#### To filter only custom words (default list is ignored)

Use `ProfanityFilter.filterOnly()` constructor and pass a list containing your custom set of words.

This will use a list which is equivalent to `Custom List`

#### To filter with a few exclusions from default list

Use `ProfanityFilter.ignore()` constructor and pass your list of custom words. Those words will be removed from the default list if they exist there.

This will use a list which is equivalent to `Default List - Custom List`
