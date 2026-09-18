import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App-wide locale controller.
///
/// Picks the locale at startup from the device (browser) locale if it matches
/// one of the supported set; otherwise falls back to English. The selection
/// is persisted to [SharedPreferences] so the user's preference survives
/// restarts and is honoured before any sign-in.
class LocaleController extends ChangeNotifier {
  LocaleController._();

  static final LocaleController instance = LocaleController._();

  static const String _prefsKey = 'app.locale';

  /// Locales exposed in the language picker. The country-code badge + native
  /// name are surfaced in the UI; the `Locale` is what we hand to Flutter.
  static const List<LocaleOption> supported = <LocaleOption>[
    LocaleOption(Locale('en'), 'EN', 'English'),
    LocaleOption(Locale('ru'), 'RU', 'Русский'),
    LocaleOption(Locale('de'), 'DE', 'Deutsch'),
    LocaleOption(Locale('fr'), 'FR', 'Français'),
    LocaleOption(Locale('zh'), 'ZH', '中文'),
    LocaleOption(Locale('es'), 'ES', 'Español'),
    LocaleOption(Locale('ja'), 'JA', '日本語'),
    LocaleOption(Locale('pt'), 'PT', 'Português'),
    LocaleOption(Locale('it'), 'IT', 'Italiano'),
    LocaleOption(Locale('ko'), 'KO', '한국어'),
    LocaleOption(Locale('vi'), 'VI', 'Tiếng Việt'),
  ];

  Locale _locale = const Locale('en');
  bool _ready = false;

  Locale get locale => _locale;
  bool get ready => _ready;

  /// Loads any saved preference (or falls back to the platform locale).
  /// Safe to call multiple times — only the first call resolves the value.
  Future<void> bootstrap() async {
    if (_ready) return;
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_prefsKey);

    Locale resolved;
    if (stored != null) {
      resolved = _decode(stored) ?? _matchPlatform() ?? const Locale('en');
    } else {
      resolved = _matchPlatform() ?? const Locale('en');
    }
    _locale = resolved;
    _ready = true;
    notifyListeners();
  }

  /// Updates the active locale and persists the choice.
  Future<void> setLocale(Locale locale) async {
    if (locale == _locale) return;
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, _encode(locale));
  }

  /// Returns the option that matches [locale], or null.
  LocaleOption? findByLocale(Locale locale) {
    for (final option in supported) {
      if (option.locale.languageCode == locale.languageCode) return option;
    }
    return null;
  }

  Locale? _matchPlatform() {
    // WidgetsBinding may not be initialised yet during bootstrap(); we
    // accept that and fall back to English when we can't read it.
    try {
      final platform = WidgetsBinding.instance.platformDispatcher.locales;
      for (final candidate in platform) {
        for (final option in supported) {
          if (option.locale.languageCode == candidate.languageCode) {
            return option.locale;
          }
        }
      }
    } catch (_) {
      // ignore — fallback below
    }
    return null;
  }

  static String _encode(Locale locale) => locale.languageCode;

  static Locale? _decode(String value) {
    final code = value.trim();
    if (code.isEmpty) return null;
    for (final option in supported) {
      if (option.locale.languageCode == code) return option.locale;
    }
    return Locale(code);
  }
}

/// Lightweight, immutable descriptor of a locale we support.
@immutable
class LocaleOption {
  const LocaleOption(this.locale, this.code, this.nativeName);

  final Locale locale;
  final String code;
  final String nativeName;

  @override
  bool operator ==(Object other) =>
      other is LocaleOption &&
      other.locale.languageCode == locale.languageCode;

  @override
  int get hashCode => locale.languageCode.hashCode;
}
