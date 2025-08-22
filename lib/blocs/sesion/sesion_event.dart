part of 'sesion_bloc.dart';

@immutable
sealed class SesionEvent {}

class InitialSesionEvent extends SesionEvent {}

class ChangeScreenEvent extends SesionEvent {
  final bool? isLogin;

  ChangeScreenEvent({this.isLogin});
}

class LoginEvent extends SesionEvent {
  final Map? data;

  LoginEvent({this.data});
}

class ValidateCode extends SesionEvent {
  final Map data;

  ValidateCode({required this.data});
}