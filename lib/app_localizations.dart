import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings = {};

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    // Return a nullable AppLocalizations instance
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<bool> load() async {
    // Load the appropriate language JSON file
    try {
      String jsonString = await rootBundle.loadString(
          'assets/lang/${locale.languageCode}.json'); // Load from specific language file
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap[locale.languageCode];
      return true;
    } catch (e) {
      print('Error loading localization file: $e');
      return false;
    }
  }

  String translate(String key) {
    // Return the translation if available, otherwise return the key
    return _localizedStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // List of supported languages
    return ['en', 'es', 'fr', 'de', 'it', 'ru', 'zh', 'ja', 'ar', 'pt']
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // Create an instance of AppLocalizations and load the appropriate JSON file
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
