import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:publicaciones_automaticas/api/api.dart';
import 'package:publicaciones_automaticas/models/auth_model.dart';
import 'package:publicaciones_automaticas/models/mypublications/mypublications_model.dart';
import 'package:publicaciones_automaticas/services/get_services.dart';

part 'sesion_event.dart';
part 'sesion_state.dart';

class SesionBloc extends Bloc<SesionEvent, SesionState> {
  final _urlApiTest = Api.urlTest;

  SesionBloc() : super(SesionLoggedInState()) {
    on<InitialSesionEvent>(_initialSesion);
    on<LoginEvent>(_login);
    on<ChangeScreenEvent>(_changeScreen);
    on<ValidateCode>(_validatedCode);
  }

  _initialSesion(InitialSesionEvent event, Emitter<SesionState> emit) async {}

  _changeScreen(ChangeScreenEvent event, Emitter<SesionState> emit) async {
    emit(state.copyWith(isLogin: event.isLogin));
  }

_login(LoginEvent event, Emitter<SesionState> emit) async {
  try {
    emit(state.copyWith(isLoadingLogin: true));

    // Login - obtener token
    Map struct = {
      'url': _urlApiTest,
      'endpoint': '/auth/login/',
      'method': 'POST',
      'body': event.data,
      'extraHeaders': {
        'Content-Type': 'application/json',
      },
    };

    Map response = await GetServices().services(struct);

    if (response['status'] == 200) {
      final token = response['data']['access_token'];

      // Llamada a /auth/me para traer datos del usuario
     Map userStruct = {
        'url': _urlApiTest,
        'endpoint': '/auth/me',
        'method': 'GET',
        'extraHeaders': {
          'Authorization': 'Bearer $token',
        },
      };


      Map userResponse = await GetServices().services(userStruct);

      if (userResponse['status'] == 200) {
        final user = AuthModel.fromJson(userResponse['data']);
        user.token = token;

        emit(state.copyWith(
          user: user,
          isLoadingLogin: false,
          isLoggedIn: true,
          response: {'status': 200},
        ));
      } else {
        emit(state.copyWith(
          isLoadingLogin: false,
          response: {
            'status': userResponse['status'],
            'error': userResponse['error'],
          },
        ));
      }
    } else {
      emit(state.copyWith(
        isLoadingLogin: false,
        response: {
          'status': response['status'],
          'error': response['error']
        },
      ));
    }
  } catch (e) {
    emit(state.copyWith(
      isLoadingLogin: false,
      isLoggedIn: false,
      response: {'status': 500, 'error': e.toString()},
    ));
  }
}


  _validatedCode(ValidateCode event, Emitter<SesionState> emit) async {
  try {
    Map struct = {
      'url': _urlApiTest,
      'endpoint': '/VentasRegistrados/ListarMisProductos/',
      'params': '${event.data['code']}',
      'method': 'GET',
      'extraHeaders': {
        'Authorization': 'Bearer ${event.data['token']}',
      },
    };

    Map response = await GetServices().services(struct);

    debugPrint("Response completo: ${response.toString()}");

    if (response['status'] == 200) {
      MyPublicationsModel myProduct = MyPublicationsModel.fromMap(response['data']);
      emit(state.copyWith(
        myProducts: myProduct,
        response: {'status': response['status']},
      ));
    } else {
      emit(state.copyWith(
        response: {
          'status': response['status'],
          'error': response['error'],
        },
      ));
    }
  } catch (e) {
    emit(state.copyWith(
      response: {'status': 500, 'error': e.toString()},
    ));
  }
}

  
}
