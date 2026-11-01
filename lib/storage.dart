import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'relaton.dart';

/// Loads and saves the list of relatons in local storage (as JSON).
class RelatonStore {
  static const _key = 'relatons';

  Future<List<Relaton>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => Relaton.fromJson(e as Map<String, dynamic>))
          .toList();
    } on FormatException {
      return [];
    }
  }

  Future<void> save(List<Relaton> relatons) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(relatons.map((r) => r.toJson()).toList()));
  }
}
