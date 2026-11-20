import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/note_item.dart';

class StorageService {
  final SharedPreferences prefs;

  StorageService(this.prefs);

  static const String themeKey = 'app_theme_dark_mode';
  static const String usernameKey = 'user_display_name';
  static const String notesKey = 'saved_notes';

  bool getDarkMode() {
    return prefs.getBool(themeKey) ?? false;
  }

  Future<bool> saveDarkMode(bool value) {
    return prefs.setBool(themeKey, value);
  }

  String getUsername() {
    return prefs.getString(usernameKey) ?? 'Guest User';
  }

  Future<bool> saveUsername(String name) {
    return prefs.setString(usernameKey, name);
  }

  List<NoteItem> getNotes() {
    final saved = prefs.getString(notesKey);

    if (saved == null) return [];

    try {
      final decoded = jsonDecode(saved) as List<dynamic>;

      return decoded.map((item) {
        return NoteItem.fromJson(
          Map<String, dynamic>.from(item as Map),
        );
      }).toList();
    } catch (error) {
      return [];
    }
  }

  Future<bool> saveNotes(List<NoteItem> notes) {
    final jsonString = jsonEncode(
      notes.map((note) => note.toJson()).toList(),
    );

    return prefs.setString(notesKey, jsonString);
  }
}