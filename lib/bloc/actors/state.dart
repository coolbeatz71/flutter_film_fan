part of 'bloc.dart';

abstract class ActorsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ActorsLoading extends ActorsState {}

class ActorsSuccess extends ActorsState {
  final Actors data;

  ActorsSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class ActorsFail extends ActorsState {
  final String message;

  ActorsFail({@required this.message});

  @override
  List<Object> get props => [message];
}
