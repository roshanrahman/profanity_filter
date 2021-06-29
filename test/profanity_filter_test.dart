import 'package:test/test.dart';
import '../lib/profanity_filter.dart';

void main() {
  test('detects default profanity', () {
    final filter = ProfanityFilter();
    expect(filter.checkStringForProfanity('hello bitches'), true);
  });

  test('default - lists all profanity', () {
    final filter = ProfanityFilter();
    expect(filter.getAllProfanity('what the fuck'), ['fuck']);
    expect(filter.getAllProfanity('what the fish'), []);
  });

  test('default with additional words - detects profanity', () {
    final filter = ProfanityFilter.filterAdditionally(['chicken']);
    expect(filter.checkStringForProfanity('hello bitches'), true);
    expect(filter.checkStringForProfanity('eat chicken'), true);
    expect(filter.checkStringForProfanity('eat chicken bitches'), true);
    expect(filter.checkStringForProfanity('eat'), false);
    expect(filter.checkStringForProfanity('pass'), false);
  });
  test('custom profanity list - detects profanity', () {
    final filter = ProfanityFilter.filterOnly(['chicken', 'dinner']);
    expect(filter.checkStringForProfanity('bitches'), false);
    expect(filter.checkStringForProfanity('eat chicken'), true);
    expect(filter.checkStringForProfanity('eat chicken dinner'), true);
  });
  test('default with ignoring words - detects profanity', () {
    final filter = ProfanityFilter.ignore(['bitch', 'bitches']);
    expect(filter.checkStringForProfanity('bitch'), false);
    expect(filter.checkStringForProfanity('dick'), true);
  });

  test('default - censors string', () {
    final filter = ProfanityFilter();
    expect(filter.censorString('what the fuck pass'), 'what the **** pass');
    expect(filter.censorString('what the fish'), 'what the fish');
  });

  test('default - censors string with case', () {
    final filter = ProfanityFilter();
    expect(filter.censorString('what the FucK pass'), 'what the **** pass');
    expect(filter.censorString('what the fish'), 'what the fish');
  });

  test('default with additional words - censors string', () {
    final filter = ProfanityFilter.filterAdditionally(['chicken', 'dinner']);
    expect(filter.censorString('what the fuck'), 'what the ****');
    expect(filter.censorString('chicken dinner'), '******* ******');
    expect(filter.censorString('fuck chicken'), '**** *******');
  });

  test('custom profanity list - censors string', () {
    final filter = ProfanityFilter.filterOnly(['chicken', 'dinner']);
    expect(filter.censorString('what the fuck'), 'what the fuck');
    expect(filter.censorString('chicken dinner'), '******* ******');
    expect(filter.censorString('fuck chicken'), 'fuck *******');
  });
  test('default - censors string - with custom replaceWith', () {
    final filter = ProfanityFilter();
    expect(filter.censorString('what the fuck', replaceWith: '[censored]'),
        'what the [censored]');
  });

  test('default with ignoring words - censors string', () {
    final filter = ProfanityFilter.ignore(['fuck']);
    expect(filter.censorString('what the fuck'), 'what the fuck');
    expect(filter.censorString('dick head'), '**** head');
  });

  test('must not detect substring as profanity', () {
    final filter = ProfanityFilter();
    expect(filter.hasProfanity('practitioner assessment'), false);
    expect(filter.censor('practitioner assessment'), 'practitioner assessment');
     expect(filter.getAllProfanity('practitioner assessment'), []);
  });
}
