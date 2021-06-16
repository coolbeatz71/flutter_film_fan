part of 'bloc.dart';

abstract class ActorsEvent extends Equatable {
  const ActorsEvent();
}

class GetActorsEvent extends ActorsEvent {
  final int id;
  GetActorsEvent(this.id);

  @override
  List<Object> get props => [id];
}
