part of 'bloc.dart';

abstract class SimilarEvent extends Equatable {
  const SimilarEvent();
}

class GetSimilarEvent extends SimilarEvent {
  final int id;
  GetSimilarEvent(this.id);

  @override
  List<Object> get props => [id];
}
