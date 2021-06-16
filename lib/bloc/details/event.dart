part of 'bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
}

class GetDetailsEvent extends DetailsEvent {
  final int id;
  GetDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}
