import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_film_fan/models/actors.dart';
import 'package:flutter_film_fan/services/api.dart';

part 'event.dart';
part 'state.dart';

class ActorsBloc extends Bloc<ActorsEvent, ActorsState> {
  ApiService service = ApiService();

  ActorsState get initialState => ActorsLoading();

  @override
  Stream<ActorsState> mapEventToState(ActorsEvent event) async* {
    if (event is GetActorsEvent) {
      yield ActorsLoading();

      try {
        Actors data = await service.getActors(event.id);
        yield ActorsSuccess(data: data);
      } catch (e) {
        yield ActorsFail(message: e.message);
      }
    }
  }
}
