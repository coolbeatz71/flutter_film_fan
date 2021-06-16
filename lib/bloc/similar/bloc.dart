import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_film_fan/models/similar.dart';
import 'package:flutter_film_fan/services/api.dart';

part 'event.dart';
part 'state.dart';

class SimilarBloc extends Bloc<SimilarEvent, SimilarState> {
  ApiService service = ApiService();

  SimilarState get initialState => SimilarLoading();

  @override
  Stream<SimilarState> mapEventToState(SimilarEvent event) async* {
    if (event is GetSimilarEvent) {
      yield SimilarLoading();

      try {
        Similar data = await service.getSimilar(event.id);
        yield SimilarSuccess(data: data);
      } catch (e) {
        yield SimilarFail(message: e.message);
      }
    }
  }
}
