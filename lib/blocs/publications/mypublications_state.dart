part of 'mypublications_bloc.dart';

@immutable
class MyPublicationsState {
  final List<MyPublicationsModel> publicaciones;
  final bool isLoading;
  final String? error;

  const MyPublicationsState({
    this.publicaciones = const [],
    this.isLoading = false,
    this.error,
  });

  MyPublicationsState copyWith({
    List<MyPublicationsModel>? publicaciones,
    bool? isLoading,
    String? error,
  }) {
    return MyPublicationsState(
      publicaciones: publicaciones ?? this.publicaciones,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class MyPublicationsInitial extends MyPublicationsState {
  const MyPublicationsInitial();
}
