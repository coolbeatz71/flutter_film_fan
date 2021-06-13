part of 'bloc.dart';

abstract class NowPlayingState extends Equatable {
  @override
  List<Object> get props => [];
}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingSuccess extends NowPlayingState {
  final NowPlaying data;

  NowPlayingSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class NowPlayingFail extends NowPlayingState {
  final String message;

  NowPlayingFail({@required this.message});

  @override
  List<Object> get props => [message];
}
