import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:publicaciones_automaticas/api/api.dart';
import 'package:publicaciones_automaticas/models/mypublications/mypublications_model.dart';
import 'package:publicaciones_automaticas/services/get_services.dart';

part 'mypublications_event.dart';
part 'mypublications_state.dart';

class MyPublicationsBloc extends Bloc<MyPublicationsEvent, MyPublicationsState> {
  final _urlApiTest = Api.urlTest;

  MyPublicationsBloc() : super(const MyPublicationsInitial()) {
    on<LoadMyPublications>(_onLoadMyPublications);
    on<ChangeStatusPublications>(_changeStatusPublications);
    on<LoadMyPublicationStatus>(_onLoadMyPublicationStatus);
  }

  Future<void> _onLoadMyPublications(LoadMyPublications event, Emitter<MyPublicationsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      // Llamada al servicio
      Map struct = {
        'url': _urlApiTest,
        'endpoint': '/api/publicaciones',
        'method': 'GET',
      };

      Map response = await GetServices().services((struct));

      if (response['status'] == 200) {
        List publicacionesList = response['data'] as List;
        final publicaciones = publicacionesList
            .map((e) => MyPublicationsModel.fromMap(e))
            .toList();

        emit(state.copyWith(
          publicaciones: publicaciones,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: response['error'],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _changeStatusPublications(ChangeStatusPublications event, Emitter<MyPublicationsState> emit) async {

    try {
      emit(state.copyWith(isLoading: true));

      // Estructura de la solicitud
      Map struct = {
        'url': _urlApiTest,
        'endpoint': '/api/publicaciones/${event.id}/estado',
        'method': 'POST',
        'body': {
          "estado": event.estado,
        },
        'extraHeaders': {
          'Content-Type': 'application/json',
        }
      };

      Map response = await GetServices().services(struct);

      if (response['status'] == 200) {
        // Si tu API retorna la publicación actualizada
        final updated = MyPublicationsModel.fromMap(response['data']);

        // Actualizamos la lista en el state reemplazando la publicación editada
        final publicaciones = state.publicaciones.map((p) {
          return p.id == updated.id ? updated : p;
        }).toList();

        emit(state.copyWith(
          publicaciones: publicaciones,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: response['error'],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }


  Future<void> _onLoadMyPublicationStatus(LoadMyPublicationStatus event, Emitter<MyPublicationsState> emit) async {
      try {
        emit(state.copyWith(isLoading: true));

        // Llamada al servicio
        Map struct = {
          'url': _urlApiTest,
          'endpoint': '/api/publicaciones/estado?estado=${event.estado}',
          'method': 'GET',
          'extraHeaders': {
            'Content-Type': 'application/json',
          }
        };

        Map response = await GetServices().services((struct));

        if (response['status'] == 200) {
          List publicacionesList = response['data'] as List;
          final publicaciones = publicacionesList
              .map((e) => MyPublicationsModel.fromMap(e))
              .toList();

          emit(state.copyWith(
            publicaciones: publicaciones,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            error: response['error'],
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          error: e.toString(),
        ));
      }
    }
}
