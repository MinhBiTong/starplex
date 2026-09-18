import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local pin book for the Library gallery.
///
/// The backend generation history has no pin column yet, so pins live in
/// `shared_preferences` as a set of generation ids. The set is process-wide
/// and notifies listeners so the gallery grid can restyle pinned cards the
/// moment one is toggled. Deleting a generation should call [forget] so a
/// recycled id can never come back looking pinned.
class LibraryPins extends ChangeNotifier {
  LibraryPins._();
  static final LibraryPins instance = LibraryPins._();

  static const _key = 'library_pinned_generation_ids';

  final Set<int> _ids = {};
  bool _loaded = false;

  bool isPinned(int generationId) => _ids.contains(generationId);

  int get count => _ids.length;

  Future<void> ensureLoaded() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw) as List;
        _ids
          ..clear()
          ..addAll(decoded.whereType<num>().map((n) => n.toInt()));
      } on FormatException {
        // Corrupt payload — start over with an empty pin set.
        _ids.clear();
      }
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> toggle(int generationId) async {
    await ensureLoaded();
    if (!_ids.remove(generationId)) _ids.add(generationId);
    notifyListeners();
    await _persist();
  }

  /// Drops ids that no longer exist in the history (bulk delete, refresh).
  Future<void> forget(Iterable<int> generationIds) async {
    await ensureLoaded();
    final before = _ids.length;
    _ids.removeAll(generationIds);
    if (_ids.length == before) return;
    notifyListeners();
    await _persist();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(_ids.toList()));
  }
}
