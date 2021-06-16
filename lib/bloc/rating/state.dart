part of 'bloc.dart';

abstract class RatingState extends Equatable {
  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingSuccess extends RatingState {
  final Rating data;

  RatingSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class RatingFail extends RatingState {
  final String message;

  RatingFail({@required this.message});

  @override
  List<Object> get props => [message];
}
