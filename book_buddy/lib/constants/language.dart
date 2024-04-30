import 'package:flutter/src/material/dropdown.dart';

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇪🇸", "española", "es"),
      Language(2, "🇺🇸", "English", "en"),
    ];
  }

  static map(DropdownMenuItem<String> Function(String value) param0) {}
}
