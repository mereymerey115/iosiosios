
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/note_item.dart';
import 'services/storage_service.dart';
import 'screens/notes_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final storage = StorageService(prefs);

  final isDarkMode = storage.getDarkMode();
  final username = storage.getUsername();
  final notes = storage.getNotes();

  runApp(
    NotesApp(
      storage: storage,
      initialDarkMode: isDarkMode,
      initialUsername: username,
      initialNotes: notes,
    ),
  );
}

class NotesApp extends StatefulWidget {
  final StorageService storage;
  final bool initialDarkMode;
  final String initialUsername;
  final List<NoteItem> initialNotes;

  const NotesApp({
    super.key,
    required this.storage,
    required this.initialDarkMode,
    required this.initialUsername,
    required this.initialNotes,
  });

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.initialDarkMode;
  }

  Future<void> changeTheme(bool value) async {
    setState(() {
      isDarkMode = value;
    });

    await widget.storage.saveDarkMode(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Offline Notes Vault',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode:
      isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: NotesScreen(
        storage: widget.storage,
        isDarkMode: isDarkMode,
        onThemeChanged: changeTheme,
        initialUsername: widget.initialUsername,
        initialNotes: widget.initialNotes,
      ),
    );
  }
}
