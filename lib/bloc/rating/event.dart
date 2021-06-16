part of 'bloc.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();
}

class PostRatingEvent extends RatingEvent {
  final int id;
  final double value;
  PostRatingEvent(this.id, this.value);

  @override
  List<Object> get props => [id, value];
}
