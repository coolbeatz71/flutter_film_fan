part of 'bloc.dart';

abstract class RecommendedState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecommendedLoading extends RecommendedState {}

class RecommendedSuccess extends RecommendedState {
  final Recommended data;

  RecommendedSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class RecommendedFail extends RecommendedState {
  final String message;

  RecommendedFail({@required this.message});

  @override
  List<Object> get props => [message];
}
