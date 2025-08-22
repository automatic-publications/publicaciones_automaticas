part of 'mypublications_bloc.dart';

@immutable
sealed class MyPublicationsEvent {}

class InitialSesionEvent extends MyPublicationsEvent {}

class ValidateCode extends MyPublicationsEvent {
  final Map data;

  ValidateCode({required this.data});
}

class LoadMyPublications extends MyPublicationsEvent {}


class ChangeStatusPublications extends MyPublicationsEvent {
  final int id;
  final String estado;

  ChangeStatusPublications({required this.id, required this.estado});
}

class LoadMyPublicationStatus extends MyPublicationsEvent {
  final String estado;

  LoadMyPublicationStatus({required this.estado});
}
