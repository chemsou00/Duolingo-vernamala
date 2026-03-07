// Project imports:
import 'package:words625/core/enums.dart';
import 'package:words625/courses/alphabets/alphabets.dart';

Map<String, String> getLanguageSounds(TargetLanguage language) {
  switch (language) {
    case TargetLanguage.kannada:
      return kannadaSounds;
    case TargetLanguage.telugu:
      return teluguSounds;
    case TargetLanguage.tamil:
      return tamilSounds;
    case TargetLanguage.malayalam:
      return malayalamSounds;
    case TargetLanguage.hindi:
      return hindiSounds;
    case TargetLanguage.bengali:
      return bengaliSounds;
    case TargetLanguage.odia:
      return odiaSounds;
    case TargetLanguage.nepali:
      return nepaliSounds;
    default:
      return {};
  }
}

Map<String, String> getLanguageVowels(TargetLanguage language) {
  switch (language) {
    case TargetLanguage.kannada:
      return kannadaVowels;
    case TargetLanguage.telugu:
      return teluguVowels;
    case TargetLanguage.tamil:
      return tamilVowels;
    case TargetLanguage.malayalam:
      return malayalamVowels;
    case TargetLanguage.hindi:
      return hindiVowels;
    case TargetLanguage.bengali:
      return bengaliVowels;
    case TargetLanguage.odia:
      return odiaVowels;
    case TargetLanguage.nepali:
      return nepaliVowels;
    default:
      return {};
  }
}

Map<String, String> getLanguageConsonants(TargetLanguage language) {
  switch (language) {
    case TargetLanguage.kannada:
      return kannadaConsonants;
    case TargetLanguage.telugu:
      return teluguConsonants;
    case TargetLanguage.tamil:
      return tamilConsonants;
    case TargetLanguage.malayalam:
      return malayalamConsonants;
    case TargetLanguage.hindi:
      return hindiConsonants;
    case TargetLanguage.bengali:
      return bengaliConsonants;
    case TargetLanguage.odia:
      return odiaConsonants;
    case TargetLanguage.nepali:
      return nepaliConsonants;
    default:
      return {};
  }
}
