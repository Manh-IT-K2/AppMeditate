import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LANGUAGE_CODE = "languageCode";

// language code
const String english = "en";
const String vietnamese = "vi";
const String chinese = "zh";
const String korean = "ko";
const String thaidlan = "th";
const String french = "fr";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String languageCode = pref.getString(LANGUAGE_CODE) ?? english;
  return _locale(languageCode);
}

Locale _locale(String languageCode){
  switch (languageCode) {
    case english:
      return const Locale(english,"US");
    case vietnamese:
      return const Locale(vietnamese,"VN");
    case chinese:
      return const Locale(chinese,"CN");
    case thaidlan:
      return const Locale(thaidlan,"TH");
    case french:
      return const Locale(french,"FR");
    case korean:
      return const Locale(korean,"KR");
    default:
      return const Locale(english,"US");
  }
}

AppLocalizations translation(BuildContext context){
  return AppLocalizations.of(context)!;
}