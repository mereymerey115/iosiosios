
import 'package:flutter/material.dart';

import '../models/note_item.dart';
import '../services/storage_service.dart';
import '../widgets/profile_section.dart';
import '../widgets/note_tile.dart';

class NotesScreen extends StatefulWidget {
  final StorageService storage;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final String initialUsername;
  final List<NoteItem> initialNotes;

  const NotesScreen({
    super.key,
    required this.storage,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.initialUsername,
    required this.initialNotes,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late String username;
  late List<NoteItem> notes;

  final usernameController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    username = widget.initialUsername;
    notes = List<NoteItem>.from(widget.initialNotes);

    usernameController.text =
    username == 'Guest User' ? '' : username;
  }

  Future<void> saveUsername() async {
    final input = usernameController.text.trim();
    final name = input.isEmpty ? 'Guest User' : input;

    final saved = await widget.storage.saveUsername(name);

    if (!mounted) return;

    if (saved) {
      setState(() {
        username = name;
      });
    }
  }

  Future<void> saveNotes() async {
    final saved = await widget.storage.saveNotes(notes);

    if (!saved && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save notes'),
        ),
      );
    }
  }

  Future<void> addNote() async {
    final title = noteController.text.trim();

    if (title.isEmpty) return;

    final now = DateTime.now();

    final note = NoteItem(
      id: now.microsecondsSinceEpoch.toString(),
      title: title,
      dateText:
      '${now.day.toString().padLeft(2, '0')}.'
          '${now.month.toString().padLeft(2, '0')}.'
          '${now.year}',
    );

    setState(() {
      notes.insert(0, note);
    });

    noteController.clear();

    await saveNotes();
  }

  Future<void> toggleNote(String id, bool value) async {
    setState(() {
      final index = notes.indexWhere((note) => note.id == id);

      if (index != -1) {
        notes[index].isCompleted = value;
      }
    });

    await saveNotes();
  }

  Future<void> deleteNote(String id) async {
    setState(() {
      notes.removeWhere((note) => note.id == id);
    });

    await saveNotes();
  }

  @override
  void dispose() {
    usernameController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Notes Vault'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Welcome, $username!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall,
                ),

                const SizedBox(height: 20),

                Card(
                  child: SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text(
                      'Save your theme preference',
                    ),
                    secondary: const Icon(Icons.dark_mode),
                    value: widget.isDarkMode,
                    onChanged: widget.onThemeChanged,
                  ),
                ),

                const SizedBox(height: 16),

                ProfileSection(
                  controller: usernameController,
                  onSave: saveUsername,
                ),

                const SizedBox(height: 16),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Notes',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge,
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: noteController,
                          decoration: const InputDecoration(
                            labelText: 'New Note',
                            hintText: 'Enter note title',
                            prefixIcon: Icon(Icons.note_add),
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (_) => addNote(),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: addNote,
                            icon: const Icon(Icons.add),
                            label: const Text('Add Note'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Saved Notes (${notes.length})',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 8),

                if (notes.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'No notes yet. Add your first note!',
                        ),
                      ),
                    ),
                  ),

                ...notes.map(
                      (note) => NoteTile(
                    key: ValueKey(note.id),
                    note: note,
                    onToggle: (value) =>
                        toggleNote(note.id, value),
                    onDelete: () => deleteNote(note.id),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
