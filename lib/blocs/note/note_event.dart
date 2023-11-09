// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_bloc.dart';

sealed class NoteEvent {
  final String filter;

  NoteEvent({this.filter = NoteFields.time});
}

class GetNotesEvent extends NoteEvent {
  GetNotesEvent({super.filter});
}

class UpdateNotesEvent extends NoteEvent {
  final Note note;

  UpdateNotesEvent({required this.note});
}

class DeleteNotesEvent extends NoteEvent {
  final int noteId;

  DeleteNotesEvent({required this.noteId});
}

class CreateNotesEvent extends NoteEvent {
  final Note note;

  CreateNotesEvent({required this.note});
}

class SearchNoteEvent extends NoteEvent {
  final String word;

  SearchNoteEvent({super.filter, required this.word});
}
