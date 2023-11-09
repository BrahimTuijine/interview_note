part of 'note_bloc.dart';

sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class NoteLoaded extends NoteState {
  final List<Note> listNote;

  NoteLoaded({required this.listNote});
}

final class NoteError extends NoteState {}
