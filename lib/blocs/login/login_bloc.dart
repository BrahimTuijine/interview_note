import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_note_app/core/db/notes_database.dart';
import 'package:interview_note_app/main.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is TryLoginEvent) {
        emit(LoginLoading());

        final result = await NotesDatabase.instance
            .getUserByName(userName: event.userName);

        if (result.isNotEmpty && result.first.password == event.password) {
          box!.put('user', result.first.toMap());
          emit(LoginLoaded());
        } else {
          emit(LoginError());
        }
      }
    });
  }
}
