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
