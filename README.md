# profanity_filter

![Dart CI](https://github.com/roshanrahman/profanity_filter/workflows/Dart%20CI/badge.svg)

Simple Dart class to create filters that check and censor strings against profanity. A default English words list is provided.

## Usage

To use this plugin, add `profanity_filter` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

### Example

```dart
import 'package:profanity_filter/profanity_filter.dart';

void main() {
  final filter = ProfanityFilter(); //Creates filter with default list.
  String myString = 'you are an ass';

  //To check if profanity exists
  bool isProfane = filter.checkStringForProfanity(
      myString); //Returns true since 'ass' is in profanity list.
  if (isProfane) {
    print('Profanity was detected');
  }

  //To censor a string
  String cleanString = filter.censorString(myString);
  print(cleanString); //Prints 'you are an ***'
}
```

### Detect if a string contains profanity

Use the `checkStringForProfanity()` method of the filter instance. Pass in the string to be tested.

#### Example

```dart
final filter = ProfanityFilter();
String badString = 'you are an ass';
filter.checkStringForProfanity(badString); //Returns true.
```

### Censor a string (replace profanity with something clean)

Use the `censorString()` method of the filter instance. Pass in the string to be censored.

#### Example

```dart
final filter = ProfanityFilter();
String badString = 'you are an ass';
String cleanString = filter.censorString('you are an ass'); //cleanString: 'you are an ***'
```

Optionally, you can provide your own clean replacement word to the `replaceWith` named parameter.
`filter.censorString(string, replaceWith:'[censored]')` will replace any profanity in `string` with `[censored]`

## Default Profanity List

The default profanity list is taken from the [LDNOOBW list](https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words), licensed under a Creative Commons Attribution 4.0 International License.

To create a filter with the default list, use the default constructor `ProfanityFilter()`

### Variations

#### To include custom words alongside default list

Use `ProfanityFilter.filterAdditionally()` constructor and pass your list of custom words.

#### To filter only custom words (default list is ignored)

Use `ProfanityFilter.filterOnly()` constructor and pass your list of custom words.

#### To filter with a few exclusions from default list

Use `ProfanityFilter.ignore()` constructor and pass your list of custom words. Those words will be removed from the default list if they exist there.
