part of 'sesion_bloc.dart';

@immutable
sealed class SesionState {
  final AuthModel? user;
  final bool isLogin;
  final Map response;
  final bool isLoggedIn;
  final bool isLoadingLogin;
  final List opciones;
  final int currentIndex;
  final MyPublicationsModel? myProducts;

  const SesionState({
    this.user,
    this.response = const {},
    this.isLogin = true,
    this.isLoggedIn = false,
    this.isLoadingLogin = false,
    this.opciones = const [],
    this.currentIndex = 0,
    this.myProducts,
  });

  SesionState copyWith({
    AuthModel? user,
    Map? response,
    bool? isLogin,
    bool? isLoggedIn,
    bool? isLoadingLogin,
    List? opciones,
    MyPublicationsModel? myProducts,
  });
}

class SesionLoggedInState extends SesionState {
  const SesionLoggedInState({
    super.user,
    super.response,
    super.isLogin,
    super.isLoggedIn,
    super.isLoadingLogin,
    super.opciones,
    super.myProducts,
  });

  @override
  SesionState copyWith({
    AuthModel? user,
    Map? response,
    bool? isLogin,
    bool? isLoggedIn,
    bool? isLoadingLogin,
    List? opciones,
    MyPublicationsModel? myProducts,
  }) {
    return SesionLoggedInState(
      user: user ?? this.user,
      opciones: opciones ?? this.opciones,
      response: response ?? this.response,
      isLogin: isLogin ?? this.isLogin,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoadingLogin: isLoadingLogin ?? this.isLoadingLogin,
      myProducts: myProducts ?? this.myProducts,
    );
  }
}
