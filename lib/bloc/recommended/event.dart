part of 'bloc.dart';

abstract class RecommendedEvent extends Equatable {
  const RecommendedEvent();
}

class GetRecommendedEvent extends RecommendedEvent {
  final int id;
  GetRecommendedEvent(this.id);

  @override
  List<Object> get props => [id];
}
