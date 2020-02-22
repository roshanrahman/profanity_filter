library profanity_filter;

import 'words/list.dart';

///Filter that lets you check and censor strings with profanity.
///
///Create an instance with the default constructor to use the default list of English profanity. Use the other constructors to customize the profanity list.
enum ProfanityFilterLanguages {
  EN,
  AR,
  CS,
  DA,
  DE,
  EO,
}

class ProfanityFilter {
  List<String> get defaultWordsToFilterOutList {
    List<String> defaultWordsToFilterOutList = [];
    defaultWordsToFilterOut.forEach((k, v) {
      defaultWordsToFilterOutList.addAll(v);
    });
    return defaultWordsToFilterOutList;
  }

  List<String> wordsToFilterOutList = [];

  ///Creates a filter with a list containing only the words provided in the list [badWordsList].
  ProfanityFilter.filterOnly(List<String> badWordsList) {
    this.wordsToFilterOutList = badWordsList;
  }

  ///Creates a filter with the default list of profanity, excluding the words in [ignoreList].
  ///
  ///As the default list may also singular and plural forms, please provide as many word variations as possible.
  ProfanityFilter.ignore(List<String> ignoreList) {
    this.wordsToFilterOutList = this.defaultWordsToFilterOutList;
    ignoreList.forEach((word) {
      this.wordsToFilterOutList.removeWhere((badWord) => badWord == word);
    });
  }

  ///Creates a filter with a list containing the default English words and the additional words provided in [badWordsList].
  ProfanityFilter.filterAdditionally(List<String> badWordsList) {
    this.wordsToFilterOutList = [
      ...this.defaultWordsToFilterOutList,
      ...badWordsList
    ];
  }

  ///Creates a filter with the default list of profanity.
  ProfanityFilter() {
    this.wordsToFilterOutList = this.defaultWordsToFilterOutList;
  }

  ///Returns `true` if [inputString] has profanity, else false.
  bool checkStringForProfanity(String inputString) {
    bool isProfane = false;
    this.wordsToFilterOutList.forEach((word) {
      if (inputString.toLowerCase().split(' ').contains(word)) {
        isProfane = true;
      }
    });
    return isProfane;
  }

  ///Returns a censored version of the [inputString], with asterisk (*) pattern as default.
  ///
  ///If [replaceWith] is provided, replaces all profane words to that [replaceWith] string.
  String censorString(String inputString, {String replaceWith}) {
    List<String> inputStringSoup = inputString.split(' ');
    this.wordsToFilterOutList.forEach((word) {
      if (replaceWith == null) {
        for (int i = 0; i < inputStringSoup.length; i++) {
          if (inputStringSoup[i] == word) {
            inputStringSoup[i] = '*' * word.length;
          }
        }
      } else {
        for (int i = 0; i < inputStringSoup.length; i++) {
          if (inputStringSoup[i] == word) {
            inputStringSoup[i] = replaceWith;
          }
        }
      }
    });
    return inputStringSoup.join(' ');
  }

  ///Returns a list of all profanity found in the string.
  List<String> getAllProfanityFoundInString(String inputString) {
    List<String> found = [];
    this.wordsToFilterOutList.forEach((word) {
      if (inputString.toLowerCase().contains(word)) {
        found.add(word);
      }
    });
    return found;
  }
}
