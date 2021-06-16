import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_film_fan/models/details.dart';
import 'package:flutter_film_fan/services/api.dart';

part 'event.dart';
part 'state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  ApiService service = ApiService();

  DetailsState get initialState => DetailsLoading();

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    if (event is GetDetailsEvent) {
      yield DetailsLoading();

      try {
        Details data = await service.getDetails(event.id);
        yield DetailsSuccess(data: data);
      } catch (e) {
        yield DetailsFail(message: e.message);
      }
    }
  }
}
