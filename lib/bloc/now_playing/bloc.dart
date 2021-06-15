import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_film_fan/models/now_playing.dart';
import 'package:flutter_film_fan/services/api.dart';

part 'event.dart';
part 'state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  ApiService service = ApiService();

  NowPlayingState get initialState => NowPlayingLoading();

  @override
  Stream<NowPlayingState> mapEventToState(NowPlayingEvent event) async* {
    if (event is GetNowPlayingEvent) {
      yield NowPlayingLoading();

      try {
        NowPlaying data = await service.getNowPlaying();
        yield NowPlayingSuccess(data: data);
      } catch (e) {
        yield NowPlayingFail(message: e.message);
      }
    }
  }
}
