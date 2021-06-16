import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_film_fan/models/rating.dart';
import 'package:flutter_film_fan/services/api.dart';

part 'event.dart';
part 'state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  ApiService service = ApiService();

  RatingState get initialState => RatingInitial();

  @override
  Stream<RatingState> mapEventToState(RatingEvent event) async* {
    if (event is PostRatingEvent) {
      yield RatingLoading();

      try {
        Rating data = await service.rateMovie(event.id, event.value);
        yield RatingSuccess(data: data);
      } catch (e) {
        yield RatingFail(message: e.message);
      }
    }
  }
}
