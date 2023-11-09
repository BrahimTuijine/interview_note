import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_note_app/core/db/notes_database.dart';
import 'package:interview_note_app/main.dart';
import 'package:interview_note_app/model/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<NoteEvent>((event, emit) async {
      emit(NoteLoading());
      if (event is SearchNoteEvent) {
        final result = await NotesDatabase.instance.searchNote(
          searchedNote: event.word,
          userId: box!.get('user')['id'],
        );
        emit(NoteLoaded(listNote: result));
      } else if (event is UpdateNotesEvent) {
        await NotesDatabase.instance.update(event.note);
      } else if (event is DeleteNotesEvent) {
        await NotesDatabase.instance.delete(event.noteId);
      } else if (event is CreateNotesEvent) {
        await NotesDatabase.instance.create(event.note);
      }
      if (event is! SearchNoteEvent) {
        final result = await NotesDatabase.instance
            .readAllNotes(userId: box!.get('user')['id'], filter: event.filter);

        emit(NoteLoaded(listNote: result));
      }
    });
  }
}
