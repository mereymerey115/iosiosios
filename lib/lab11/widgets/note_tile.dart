import 'package:flutter/material.dart';

import '../models/note_item.dart';

class NoteTile extends StatelessWidget {
  final NoteItem note;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;

  const NoteTile({
    super.key,
    required this.note,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(note.id),
      child: ListTile(
        leading: Checkbox(
          value: note.isCompleted,
          onChanged: (value) {
            onToggle(value ?? false);
          },
        ),
        title: Text(
          note.title,
          style: TextStyle(
            decoration: note.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(note.dateText),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          onPressed: onDelete,
        ),
      ),
    );
  }
}