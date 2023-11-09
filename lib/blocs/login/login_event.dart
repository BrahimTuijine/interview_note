part of 'login_bloc.dart';

sealed class LoginEvent {}

class TryLoginEvent extends LoginEvent {
  final String userName;
  final String password;

  TryLoginEvent({required this.userName, required this.password});
}
