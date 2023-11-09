import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:interview_note_app/blocs/note/note_bloc.dart';
import 'package:interview_note_app/pages/edit_note_page.dart';
import '../model/note.dart';

class NoteDetailPage extends HookWidget {
  final Note note;
  const NoteDetailPage({
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final title = useState<String>(note.title);
    final description = useState<String>(note.description);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () async {
                final (String, String) updatedNote =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddEditNotePage(note: note),
                ));
                title.value = updatedNote.$1;
                description.value = updatedNote.$2;
              }),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<NoteBloc>().add(DeleteNotesEvent(noteId: note.id!));
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Text(title.value, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMd().format(note.createdTime),
              // style: const TextStyle(color: Colors.white38),
            ),
            const SizedBox(height: 8),
            Text(
              description.value,
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
