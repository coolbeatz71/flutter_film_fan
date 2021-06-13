part of 'bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetNowPlayingEvent extends NowPlayingEvent {}
