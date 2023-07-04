class LanguageModel {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  LanguageModel(this.id, this.flag, this.name, this.languageCode);

  static List<LanguageModel> listLanguage() {
    return <LanguageModel>[
      LanguageModel(1, "🇺🇸", "English", "en"),
      LanguageModel(2, "🇻🇳", "VietNam", "vi"),
      LanguageModel(1, "🇰🇷", "Korea", "ko"),
      LanguageModel(2, "🇫🇷", "France", "fr"),
      LanguageModel(1, "🇨🇳", "China", "zh"),
      LanguageModel(2, "🇹🇭", "Thailand", "th")
    ];
  }
}
