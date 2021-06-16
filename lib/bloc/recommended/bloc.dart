import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_film_fan/models/recommended.dart';
import 'package:flutter_film_fan/services/api.dart';

part 'event.dart';
part 'state.dart';

class RecommendedBloc extends Bloc<RecommendedEvent, RecommendedState> {
  ApiService service = ApiService();

  RecommendedState get initialState => RecommendedLoading();

  @override
  Stream<RecommendedState> mapEventToState(RecommendedEvent event) async* {
    if (event is GetRecommendedEvent) {
      yield RecommendedLoading();

      try {
        Recommended data = await service.getRecommended(event.id);
        yield RecommendedSuccess(data: data);
      } catch (e) {
        yield RecommendedFail(message: e.message);
      }
    }
  }
}
