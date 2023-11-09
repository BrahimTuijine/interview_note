import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interview_note_app/blocs/note/note_bloc.dart';
import 'package:interview_note_app/main.dart';
import '../model/note.dart';
import '../widget/note_form_widget.dart';

class AddEditNotePage extends HookWidget {
  final Note? note;

  AddEditNotePage({
    super.key,
    this.note,
  });

  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: note == null ? null : Colors.grey.shade700,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (note == null) {
                      context.read<NoteBloc>().add(CreateNotesEvent(
                          note: Note(
                              userId: box!.get('user')['id'],
                              title: title,
                              description: description,
                              createdTime: DateTime.now())));
                    } else {
                      context.read<NoteBloc>().add(UpdateNotesEvent(
                          note: note!
                              .copy(title: title, description: description)));
                    }
                    Navigator.of(context).pop((title, description));
                  }
                },
                child: const Text('Save'),
              ),
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            onSavedDescription: (value) {
              description = value!;
            },
            onSavedTitle: (value) {
              title = value!;
            },
            title: note?.title,
            description: note?.description,
          ),
        ),
      );
}
